#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "myLib.h"
#include "text.h"

typedef struct {
    const unsigned char* data;
    int length;
    int frequency;
    int isPlaying;
    int loops;
    int duration;
    int priority;
} SOUND;

SOUND soundA;
SOUND soundB;
int vbCountA;
int vbCountB;

void setupSounds();
void playSoundA( const unsigned char* sound, int length, int frequency, int isLooping);
void playSoundB( const unsigned char* sound, int length, int frequency, int isLooping);
void muteSound();
void unmuteSound();
void stopSound();
void pauseSound();
void unpauseSound();
void setupInterrupts();
void interruptHandler();

void setupSounds()
{
    REG_SOUNDCNT_X = SND_ENABLED;
    REG_SOUNDCNT_H = SND_OUTPUT_RATIO_100 |
                        DSA_OUTPUT_RATIO_100 |
                        DSA_OUTPUT_TO_BOTH |
                        DSA_TIMER0 |
                        DSA_FIFO_RESET |
                        DSB_OUTPUT_RATIO_100 |
                        DSB_OUTPUT_TO_BOTH |
                        DSB_TIMER1 |
                        DSB_FIFO_RESET;
    REG_SOUNDCNT_L = 0;
}

void playSoundA( const unsigned char* sound, int length, int frequency, int isLooping) {
        dma[1].cnt = 0;
        vbCountA = 0;

        int interval = 16777216/frequency;

        DMANow(1, sound, (volatile void*) REG_FIFO_A, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

        REG_TM0CNT = 0;

        REG_TM0D = -interval;
        REG_TM0CNT = TIMER_ON;

        soundA.data = sound;
        soundA.length = length;
        soundA.frequency = frequency;
        soundA.isPlaying = 1;
        soundA.loops = isLooping;
        soundA.duration = ((60*length)/frequency) - ((length/frequency)*3)-1;
}


void playSoundB( const unsigned char* sound, int length, int frequency, int isLooping) {
        dma[2].cnt = 0;
        vbCountB = 0;

        int interval = 16777216/frequency;

        DMANow(2, sound, (volatile void*) REG_FIFO_B, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

        REG_TM1CNT = 0;

        REG_TM1D = -interval;
        REG_TM1CNT = TIMER_ON;

        soundB.data = sound;
        soundB.length = length;
        soundB.frequency = frequency;
        soundB.isPlaying = 1;
        soundB.loops = isLooping;
        soundB.duration = ((60*length)/frequency) - ((length/frequency)*3)-1;
}

void muteSound()
{
    REG_SOUNDCNT_X = 0;
}

void unmuteSound()
{
    REG_SOUNDCNT_X = SND_ENABLED;
}

void pauseSound()
{
    REG_TM0CNT = 0;
    REG_TM1CNT = 0;
    soundA.isPlaying = 0;
    soundB.isPlaying = 0;
}

void unpauseSound()
{
    REG_TM0CNT = TIMER_ON;
    REG_TM1CNT = TIMER_ON;
    soundA.isPlaying = 1;
    soundB.isPlaying = 1;

}

void stopSound()
{
    dma[1].cnt = 0;
    soundA.isPlaying = 0;
    dma[2].cnt = 0;
    soundB.isPlaying = 0;
}

void setupInterrupts()
{
    REG_IME = 0;
    REG_INTERRUPT = (unsigned int)interruptHandler;
    REG_IE |= INT_VBLANK;
    REG_DISPSTAT |= INT_VBLANK_ENABLE;
    REG_IME = 1;
}

void interruptHandler()
{
    REG_IME = 0;
    if(REG_IF & INT_VBLANK)
    {
        if(soundA.isPlaying == 1) {
            vbCountA++;
        }
        if (vbCountA > soundA.duration) {
            if (soundA.loops == 1) {
                playSoundA(soundA.data,soundA.length,soundA.frequency,1);
            } else {
                dma[1].cnt = 0;
                soundA.isPlaying = 0;
            }
        }
        if(soundB.isPlaying == 1) {
            vbCountB++;
        }
        if (vbCountB > soundB.duration) {
            if (soundB.loops == 1) {
                playSoundB(soundB.data,soundB.length,soundB.frequency,soundB.loops);
            } else {
                dma[2].cnt = 0;
                soundB.isPlaying = 0;
            }
        }
        REG_IF = INT_VBLANK;
    }
    REG_IME = 1;
}
