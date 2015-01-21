#ifndef __SOUNDH__
#define __SOUNDH__

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

#endif

