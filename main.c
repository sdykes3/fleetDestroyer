#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "myLib.h"
#include "sound.h"
#include "text.h"

#include "sprites.h"
#include "starsSmall.h"
#include "starsBig.h"
#include "splash.h"
#include "start.h"
#include "howto.h"

#include "Ballad.h"
#include "playerShot.h"
#include "expl01.h"
#include "expl02.h"
#include "expl03.h"
#include "explosion.h"
#include "crash.h"
#include "crash0.h"
#include "longCrash.h"
#include "Powerup8.h"
#include "Powerup6.h"
#include "alert.h"

unsigned int buttons;
unsigned int oldButtons;
char buffer[41];
int hOff=0;
int vOff=0;
OBJ_ATTR shadowOAM[128];
int bigRow, bigCol;
int collMapSize = 256;

#define ROWMASK 0xFF
#define COLMASK 0x1FF
#define MAXPLAYERHP 15
#define MAXBULLETS 5
#define MAXBOSSBULLETS 10
#define MAXEXPLOSIONS 20
#define MAXHEALTHPACKS 8
#define BULLETSPEED 2
#define MAXASTEROIDS 8
#define ALERTDELAYVALUE 75

typedef struct {
	int row;
	int col;
    int bigRow;
    int bigCol;
	int width;
    int height;
    int health;
    int aniCounter;
    int aniState;
    int prevAniState;
    int currFrame;
    int palBank;
    int whichPal;
} MOVOBJ;

typedef struct{
    int row;
    int col;
    int rVel;
    int cVel;
    int active;
    int size;
    int width;
    int height;
    int health;
    int type;
    int spriteSheetY;
    int spriteSizeAttr;
    int aniCounter;
    int aniState;
    int prevAniState;
    int currFrame;
} HOSTILE;

typedef struct{
    int row;
    int col;
    int cVel;
    int active;
    int aniCounter;
    int aniState;
} BULLET;

typedef struct{
    int row;
    int col;
    int cVel;
    int active;
    int shape;
    int spriteSheetY;
    int spriteSizeAttr;
    int aniCounter;
    int currFrame;
    bool isBulletHit;
} EXPLOSION;

typedef struct{
    int row;
    int col;
    int cVel;
    int active;
    int size;
} HEALTHPACK;

typedef struct{
    int active;
} HEALTH;

MOVOBJ player;
HOSTILE theBoss;
BULLET bullets[MAXBULLETS];
BULLET bossBullets[MAXBOSSBULLETS];
EXPLOSION explosions[MAXEXPLOSIONS];
HEALTHPACK healthPacks[MAXHEALTHPACKS];
HOSTILE asteroids[MAXASTEROIDS];
HOSTILE asteroidType[6];
HEALTH health[15];
int seed = 0;
int collectedHP = 0;
int howToState = 0;
int howToBullet = 60;
int alertDelay = ALERTDELAYVALUE;
int bulletTimer = 0;
int bossMoveTimer = 0;
bool bossMoveDirIsUp = false;
bool cheating = false;

void splash();
void howto();
void game();
void preBoss();
void bossFollow();
void bossRandom();
void pause();
void win();
void lose();
void splashPrep();
void howtoPrep();
void gamePrep();
void bossPrep();
void pausePrep();
void losePrep();
void winPrep();
void alwaysCallThese();

void shoot();
void bossShoot();
void bulletExplode(int row, int col);
void asteroidExplode(int row, int col, HOSTILE asteroid);
void playerHit(int row, int col, bool hitByAsteroid);
void setupAsteroidTypes();
HOSTILE resetAsteroid();
void updateBullets();
void updateDebris();

enum { INACTIVE, ACTIVE };
enum { FRONT, RIGHT, LEFT, BACK, PLAYERIDLE } state;
enum { STARTSCREEN, HOWTOSCREEN, GAME, PREBOSS, BOSSFOLLOW, BOSSRANDOM,
    PAUSESCREEN, WINSCREEN, LOSESCREEN } gameState;


int main()
{
    REG_DISPCTL = MODE3 | BG2_ENABLE;
    setupInterrupts();
    setupSounds();
    splashPrep();
    playSoundA(Ballad,BALLADLEN,BALLADFREQ, 1);

    for(;;)
    {
        oldButtons = buttons;
        buttons = BUTTONS;

        switch(gameState)
        {
            case STARTSCREEN:
                splash();
                break;
            case HOWTOSCREEN:
                howto();
                break;
            case GAME:
                game();
                break;
            case PREBOSS:
                preBoss();
                break;
            case BOSSRANDOM:
                bossRandom();
                break;
            case BOSSFOLLOW:
                bossFollow();
                break;
            case PAUSESCREEN:
                pause();
                break;
            case WINSCREEN:
                win();
                break;
            case LOSESCREEN:
                lose();
                break;
        }
    }
	return 0;
}

void game() {
    hOff++;
    if(collectedHP >= MAXHEALTHPACKS) {
        gameState = PREBOSS;
        return;
    }
    alwaysCallThese();
}

void gamePrep() {
    REG_DISPCTL = MODE0 | BG0_ENABLE | BG2_ENABLE | SPRITE_ENABLE;
    REG_BG2CNT = CBB(0) | SBB(27) | BG_SIZE1 | COLOR256;
    loadPalette(starsSmallPal);
    DMANow(3, starsSmallTiles, &CHARBLOCKBASE[0], starsSmallTilesLen/2);
    DMANow(3, starsSmallMap, &SCREENBLOCKBASE[27], starsSmallMapLen/2);

    REG_BG0CNT = CBB(2) | SBB(25) | BG_SIZE1 | COLOR256;
    DMANow(3, starsBigTiles, &CHARBLOCKBASE[2], starsBigTilesLen/2);
    DMANow(3, starsBigMap, &SCREENBLOCKBASE[25], starsBigMapLen/2);

    DMANow(3, spritesPal, SPRITE_PALETTE, spritesPalLen/2);
    DMANow(3, spritesTiles, &CHARBLOCKBASE[4], spritesTilesLen/2);

    hideSprites();
}

void bossRandom() {
    if(theBoss.col >= 175) {
        theBoss.col += theBoss.cVel;
        //intimidating noise
        //loop boss music
    }

    if(bulletTimer%30==0) {
        bulletTimer = 0;
        bossShoot();
    }
    bulletTimer++;
    bossMoveTimer++;

    if(bossMoveDirIsUp) {
        theBoss.row -= theBoss.rVel;
    } else {
        theBoss.row += theBoss.rVel;
    }

    if(bossMoveTimer%90==0) {
        bossMoveDirIsUp = !bossMoveDirIsUp;
        bossMoveTimer = 0;
        gameState = BOSSFOLLOW;
        bossFollow();
        return;
    }

    if(theBoss.row > 0) {
        theBoss.row--;
    } else {
        theBoss.row = 0;
    }
    if(theBoss.row < (160 - theBoss.height)) {
        theBoss.row++;
    } else {
        theBoss.row = 160 - theBoss.height;
    }
    alwaysCallThese();
}

void bossFollow() {
    if(theBoss.col >= 175) {
        theBoss.col += theBoss.cVel;
    }

    if(bulletTimer%30==0) {
        bulletTimer = 0;
        bossShoot();
    }
    bulletTimer++;
    bossMoveTimer++;

    //follow state, random state : switch between those
    if(bossMoveTimer%90==0) {
        bossMoveTimer = 0;
        gameState = BOSSRANDOM;
        bossRandom();
        return;
    }

    if(theBoss.row - 7 > player.row) {
        theBoss.row -= theBoss.rVel;
        if(theBoss.row > 0) {
            theBoss.row--;
        } else {
            theBoss.row = 0;
        }
    } else if (theBoss.row + 7 < player.row) {
        theBoss.row += theBoss.rVel;
        if(theBoss.row < (160 - theBoss.height)) {
            theBoss.row++;
        } else {
            theBoss.row = 160 - theBoss.height;
        }
    }
    alwaysCallThese();
}

void preBoss() {
    hOff++;
    alwaysCallThese();
    int allGone = 0;
    int i;
    for(i=0; i < MAXASTEROIDS; i++) {
        if (asteroids[i].active == ACTIVE) {
            allGone = 1;
        }
    }
    if (allGone == 0) {
        if(alertDelay == ALERTDELAYVALUE) { //if original value, so only happens once
            playSoundB(alert,ALERTLEN,ALERTFREQ, 0);
        }
        alertDelay--;
        if (alertDelay <= 0) {
            gameState = BOSSRANDOM;
            bossPrep();
            return;
        }
    }
}

void bossPrep() {
    theBoss.active = ACTIVE;
    theBoss.cVel = -1;
}

void hideSprites() {
    int i;
    for (i = 0; i < (128); i++) {
        shadowOAM[i].attr0 = ATTR0_HIDE;
    }
}

void animate() {
    if (player.aniState != PLAYERIDLE) {
        player.prevAniState = player.aniState;
    }
    player.aniState = PLAYERIDLE;

    if(player.aniCounter%10==0) {
        if(cheating) {
            player.whichPal++;
            if(player.whichPal > 5) {
                player.whichPal = 3;
            }
        }
    }

    if(BUTTON_HELD(BUTTON_LEFT)) {
        player.aniState = FRONT;
    }
    if(BUTTON_HELD(BUTTON_RIGHT)) {
        player.aniState = FRONT;
    }
    if(BUTTON_HELD(BUTTON_UP)) {
        player.aniState = LEFT;
    }
    if(BUTTON_HELD(BUTTON_DOWN)) {
        player.aniState = RIGHT;
    }
    if(player.aniCounter%20==0) {
        player.aniCounter = 0;
        if(player.aniState == PLAYERIDLE) {
            if (player.currFrame == 1) {
                player.currFrame = 0;
            } else {
                player.currFrame = 1;
            }
        } else {
            if (player.currFrame == 2) {
                player.currFrame = 1;
            } else {
                player.currFrame++;
            }
        }
    }
    if(player.aniState == PLAYERIDLE) {
        player.aniCounter++;
        player.aniState = FRONT;
    } else {
        player.aniCounter++;
    }
    int i;
    for(i=0; i < MAXEXPLOSIONS; i++) {
        if(explosions[i].active == ACTIVE) {
            explosions[i].aniCounter++;
            //if tiny hit explosion, disappear faster
            if(((explosions[i].spriteSheetY == 237) || (explosions[i].spriteSheetY == 239)) && explosions[i].aniCounter%3 == 0) {
                explosions[i].active = INACTIVE;
            } else if (explosions[i].aniCounter%8 == 0) { //if bigger, go through frames

                if (explosions[i].currFrame == 0) {
                    explosions[i].active = INACTIVE;
                } else {
                    explosions[i].currFrame--;
                }
            }
        }
    }
}

void updateOAM() {
    shadowOAM[MAXEXPLOSIONS].attr0 = (player.row & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
    shadowOAM[MAXEXPLOSIONS].attr1 = (player.col & COLMASK)| ATTR1_SIZE32;
    shadowOAM[MAXEXPLOSIONS].attr2 = (SPRITEOFFSET16(player.currFrame*4, player.prevAniState*4)) | (ATTR2_PALBANK (player.whichPal));

    if(theBoss.active == ACTIVE){
        shadowOAM[1+MAXEXPLOSIONS].attr0 = (theBoss.row & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
        shadowOAM[1+MAXEXPLOSIONS].attr1 = (theBoss.col & COLMASK) | theBoss.spriteSizeAttr;
        shadowOAM[1+MAXEXPLOSIONS].attr2 = (SPRITEOFFSET16(0, theBoss.spriteSheetY)) | (ATTR2_PALBANK (2));
    } else {
        shadowOAM[1+MAXEXPLOSIONS].attr0 = ATTR0_HIDE;
    }

    int i;
    for (i=0; i<player.health; ++i) {
        if(health[i].active == ACTIVE) {
            shadowOAM[i+2+MAXEXPLOSIONS].attr0 = (0 & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[i+2+MAXEXPLOSIONS].attr1 = (i*8 & COLMASK) | ATTR1_SIZE8;
            shadowOAM[i+2+MAXEXPLOSIONS].attr2 = SPRITEOFFSET16(0, 205);
        } else {
            shadowOAM[i+2+MAXEXPLOSIONS].attr0 = ATTR0_HIDE;
        }
    }
    for (i=0; i<MAXEXPLOSIONS; ++i) {
        if(explosions[i].isBulletHit) { //draw on top of player and boss
            if(explosions[i].active == ACTIVE) {
                shadowOAM[i].attr0 = (explosions[i].row & ROWMASK) | ATTR0_4BPP | explosions[i].shape;
                shadowOAM[i].attr1 = (explosions[i].col & ROWMASK) | explosions[i].spriteSizeAttr;
                if(explosions[i].currFrame == -1) {
                    shadowOAM[i].attr2 = (SPRITEOFFSET16(0, explosions[i].spriteSheetY)) | (ATTR2_PALBANK (1));
                } else {
                    shadowOAM[i].attr2 = (SPRITEOFFSET16(0, (explosions[i].currFrame*4)+520)) | (ATTR2_PALBANK (1));
                }
            } else {
                shadowOAM[i].attr0 = ATTR0_HIDE;
            }
        } else { //draw in normal order, below player and boss
            if(explosions[i].active == ACTIVE) {
                shadowOAM[i+2+MAXPLAYERHP+MAXEXPLOSIONS].attr0 = (explosions[i].row & ROWMASK) | ATTR0_4BPP | explosions[i].shape;
                shadowOAM[i+2+MAXPLAYERHP+MAXEXPLOSIONS].attr1 = (explosions[i].col & ROWMASK) | explosions[i].spriteSizeAttr;
                if(explosions[i].currFrame == -1) {
                    shadowOAM[i+2+MAXPLAYERHP+MAXEXPLOSIONS].attr2 = (SPRITEOFFSET16(0, explosions[i].spriteSheetY)) | (ATTR2_PALBANK (1));
                } else {
                    shadowOAM[i+2+MAXPLAYERHP+MAXEXPLOSIONS].attr2 = (SPRITEOFFSET16(0, (explosions[i].currFrame*4)+520)) | (ATTR2_PALBANK (1));
                }
            } else {
                shadowOAM[i+2+MAXPLAYERHP+MAXEXPLOSIONS].attr0 = ATTR0_HIDE;
            }
        }
    }
    for(i=0; i<MAXBULLETS; i++){
        if(bullets[i].active == ACTIVE){
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)].attr0 = (bullets[i].row & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)].attr1 = (bullets[i].col & COLMASK) | ATTR1_SIZE8;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)].attr2 = SPRITEOFFSET16(0, 173);
        } else {
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)].attr0 = ATTR0_HIDE;
        }
    }
    for(i=0; i<MAXBOSSBULLETS; i++){
        if(bossBullets[i].active == ACTIVE){
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS].attr0 = (bossBullets[i].row & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS].attr1 = (bossBullets[i].col & COLMASK) | ATTR1_SIZE8;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS].attr2 = SPRITEOFFSET16(0, 175);
        } else {
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS].attr0 = ATTR0_HIDE;
        }
    }
    for (i=0; i<MAXHEALTHPACKS; ++i) {
        if(healthPacks[i].active == ACTIVE) {
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS].attr0 = (healthPacks[i].row & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS].attr1 = (healthPacks[i].col & COLMASK) | ATTR1_SIZE16;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS].attr2 = (SPRITEOFFSET16(0, 460)) | (ATTR2_PALBANK (1));
        } else {
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS].attr0 = ATTR0_HIDE;
        }
    }
    for(i=0; i<MAXASTEROIDS; i++){
        if(asteroids[i].active == ACTIVE){
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS+MAXHEALTHPACKS].attr0 = (asteroids[i].row & ROWMASK) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS+MAXHEALTHPACKS].attr1 = (asteroids[i].col & COLMASK) | asteroids[i].spriteSizeAttr;
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS+MAXHEALTHPACKS].attr2 = SPRITEOFFSET16(0, asteroids[i].spriteSheetY);
        } else {
            shadowOAM[i+2+MAXPLAYERHP+(2*MAXEXPLOSIONS)+MAXBULLETS+MAXBOSSBULLETS+MAXHEALTHPACKS].attr0 = ATTR0_HIDE;
        }
    }
}


void initialize() {
    player.width = 32;
    player.height = 32;
	player.row = 160/2-player.width/2;
	player.col = 240/2-player.height/2;
    player.health = 5;
	player.aniCounter = 0;
    player.currFrame = 0;
	player.aniState = FRONT;
    player.whichPal = 0;

    theBoss.width = 32;
    theBoss.height = 32;
    theBoss.row = 160/2-theBoss.width/2;
    theBoss.col = 250;
    theBoss.health = 25;
    theBoss.cVel = 1;
    theBoss.rVel = 1;
    theBoss.size = 64;
    theBoss.spriteSheetY = 12;
    theBoss.spriteSizeAttr = ATTR1_SIZE32;
    theBoss.active = INACTIVE;
    theBoss.aniCounter = 0;
    theBoss.currFrame = 0;
    theBoss.aniState = FRONT;

    buttons = BUTTONS;
	hOff = 0;
	vOff = 0;
    setupAsteroidTypes();

    int i;
    for(i=0; i<player.health; i++) {
        health[i].active = ACTIVE;
    }
    for (i=0; i<MAXHEALTHPACKS; ++i) {
        healthPacks[i].active = INACTIVE;
        healthPacks[i].cVel = -1;
        healthPacks[i].size = 16;
        healthPacks[i].row = rand()%(160-healthPacks[i].size);
        healthPacks[i].col = (rand()%240)+250;
    }
    healthPacks[0].active = ACTIVE;

    for(i=0; i<MAXASTEROIDS; i++) { //choose random type then assign values
        asteroids[i] = resetAsteroid();
    }
    for(i=0; i<MAXBULLETS; i++){
        bullets[i].active = INACTIVE;
        bullets[i].row = 0;
        bullets[i].col = 0;
        bullets[i].cVel = BULLETSPEED;
    }
    for(i=0; i<MAXBOSSBULLETS; i++){
        bossBullets[i].active = INACTIVE;
        bossBullets[i].row = 0;
        bossBullets[i].col = 0;
        bossBullets[i].cVel = BULLETSPEED;
    }
    for(i=0; i<MAXEXPLOSIONS; i++){
        explosions[i].active = INACTIVE;
        explosions[i].row = 0;
        explosions[i].col = 0;
        explosions[i].cVel = -1;
        explosions[i].shape = ATTR0_SQUARE;
        explosions[i].spriteSheetY = 237;
        explosions[i].spriteSizeAttr = ATTR1_SIZE8;
        explosions[i].isBulletHit = false;
    }
}

void cheat() {
    cheating = !cheating;
    playSoundB(Powerup6,POWERUP6LEN,POWERUP6FREQ, 0);
    if(!cheating) {
        player.whichPal = 0;
    } else {
        player.whichPal = 3;
    }
    //play sound when activated / deactivated
}

void shoot() {
    int i;
    for(i=0; i<MAXBULLETS; i++){
        if(bullets[i].active == INACTIVE){
            playSoundB(playerShot,PLAYERSHOTLEN,PLAYERSHOTFREQ, 0);
            bullets[i].active = ACTIVE;
            bullets[i].row = player.row + 11;
            bullets[i].col = player.col + 30;
            break;
        }
    }
}

void bossShoot() {
    int i;
    for(i=0; i<MAXBOSSBULLETS; i++){
        if(bossBullets[i].active == INACTIVE){
            //playSoundB(playerShot,PLAYERSHOTLEN,PLAYERSHOTFREQ, 0);
            bossBullets[i].active = ACTIVE;
            bossBullets[i].row = theBoss.row + 11;
            bossBullets[i].col = theBoss.col;
            break;
        }
    }
}

void bulletExplode(int row, int col) {
    int i;
    //go through array and find the first inactive explosion, make it active
    for(i=0; i < MAXEXPLOSIONS; i++) {
        if(explosions[i].active == INACTIVE) {
            explosions[i].cVel = -1;
            explosions[i].active = ACTIVE;
            explosions[i].row = row;
            explosions[i].col = col;
            explosions[i].shape = ATTR0_SQUARE;
            explosions[i].spriteSizeAttr = ATTR1_SIZE8;
            explosions[i].spriteSheetY = 237;
            explosions[i].currFrame = -1;
            explosions[i].isBulletHit = true;
            return; //because we only want one explosion to be activated
        }
    }
}

void asteroidExplode(int row, int col, HOSTILE asteroid) {
    int i;
    //go through array and find the first inactive explosion, make it active
    for(i=0; i < MAXEXPLOSIONS; i++) {
        if(explosions[i].active == INACTIVE) {
            explosions[i].cVel = -1;
            explosions[i].active = ACTIVE;
            explosions[i].spriteSizeAttr = ATTR1_SIZE64;
            explosions[i].shape = ATTR0_TALL;
            explosions[i].isBulletHit = false;
            if(asteroid.type == 0 || asteroid.type == 1 || asteroid.type == 2) {
                explosions[i].spriteSheetY = 522;
                explosions[i].currFrame = 1;
                explosions[i].row = row - 32;
                explosions[i].col = col + 6;
            } else if (asteroid.type == 3) {
                explosions[i].spriteSheetY = 524;
                explosions[i].currFrame = 0;
                explosions[i].row = row - 30;
                explosions[i].col = col + 4;
            } else {
                explosions[i].spriteSheetY = 520;
                explosions[i].currFrame = 2;
                explosions[i].row = row - 32;
                explosions[i].col = col + 12;
            }
            return; //because we only want one explosion to be activated
        }
    }
}

void playerHit(int row, int col, bool hitByAsteroid) {
    int i;
    //go through array and find the first inactive explosion, make it active
    for(i=0; i < MAXEXPLOSIONS; i++) {
        if(explosions[i].active == INACTIVE) {
            explosions[i].cVel = -1;
            explosions[i].active = ACTIVE;
            if(hitByAsteroid) {
                explosions[i].shape = ATTR0_TALL;
                explosions[i].spriteSizeAttr = ATTR1_SIZE64;
                explosions[i].spriteSheetY = 524;
                explosions[i].currFrame = 0;
                explosions[i].row = row - 16;
                explosions[i].col = col + (player.width) - 16;
            } else { //hit by boss bullets
                explosions[i].row = row;
                explosions[i].col = col + 4;
                explosions[i].shape = ATTR0_SQUARE;
                explosions[i].spriteSizeAttr = ATTR1_SIZE8;
                explosions[i].spriteSheetY = 239;
                explosions[i].currFrame = -1;
            }
            return; //because we only want one explosion to be activated
        }
    }
}

void updateBullets() {
    int i,j;
    for(i=0; i<MAXBULLETS; i++){
        if(bullets[i].active == ACTIVE){
            bullets[i].col += bullets[i].cVel;
            if(bullets[i].row <= 0 || bullets[i].row >= 160 ||
               bullets[i].col <= 0 || bullets[i].col >= 240){
                bullets[i].active = INACTIVE;
            }
            if(bullets[i].active == ACTIVE){
                for(j = 0; j<MAXASTEROIDS; j++){
                    if(asteroids[j].active == ACTIVE && bullets[i].row+3 >= (asteroids[j].row+(asteroids[j].size/4)) && bullets[i].row+3 <= asteroids[j].row+asteroids[j].size-(asteroids[j].size/4) &&
                       bullets[i].col+8 <= asteroids[j].col+asteroids[j].size-(asteroids[j].size/4) && bullets[i].col+8 >= asteroids[j].col+(asteroids[j].size/4) ){

                        asteroids[j].health--;
                        bulletExplode(bullets[i].row, bullets[i].col);

                        bullets[i].active = INACTIVE;
                        if(asteroids[j].health == 0){
                            asteroids[j].active = INACTIVE;
                            asteroidExplode(bullets[i].row, bullets[i].col, asteroids[j]);
                            playSoundB(crash0,CRASH0LEN,CRASH0FREQ, 0);
                            if(gameState != PREBOSS) {
                                asteroids[j] = resetAsteroid();
                            }
                        }
                    }
                }
                if(bullets[i].row+8 >= (theBoss.row+(theBoss.height/4)) && bullets[i].row+3 <= theBoss.row+theBoss.height-(theBoss.height/4) &&
                       bullets[i].col+4 <= theBoss.col+theBoss.width-(theBoss.width/4) && bullets[i].col+4 >= theBoss.col+(theBoss.width/4) ){

                    theBoss.health--;
                    bulletExplode(bullets[i].row, bullets[i].col);
                    bullets[i].active = INACTIVE;
                    if(theBoss.health == 0){
                        stopSound();
                        playSoundB(explosion,EXPLOSIONLEN,EXPLOSIONFREQ, 0);
                        //playSoundB(longCrash,LONGCRASHLEN,LONGCRASHFREQ, 0);
                        gameState = WINSCREEN;
                        winPrep();
                        return;
                    }
                }

            }
        }
    }
    for(i=0; i<MAXBOSSBULLETS; i++){
        if(bossBullets[i].active == ACTIVE){
            bossBullets[i].col -= bossBullets[i].cVel;
            if(bossBullets[i].row <= (-4) || bossBullets[i].row >= 160 ||
               bossBullets[i].col <= (-8) || bossBullets[i].col >= 240){
                bossBullets[i].active = INACTIVE;
            }
            if(bossBullets[i].active == ACTIVE){
                if(bossBullets[i].row+8 >= (player.row+(player.height/4)) && bossBullets[i].row+3 <= player.row+player.height-(player.height/4) &&
                   bossBullets[i].col+4 <= player.col+player.width-(player.width/4) && bossBullets[i].col+4 >= player.col+(player.width/4) ){

                    playSoundB(crash,CRASHLEN,CRASHFREQ, 0);
                    playerHit(bossBullets[i].row, bossBullets[i].col, false);
                    if(!cheating) {
                        player.health--;
                    }
                    //boss bullet hit animation
                    bossBullets[i].active = INACTIVE;
                }
            }
        }
    }
    for(i=0; i<MAXEXPLOSIONS; i++){
        if(explosions[i].active == ACTIVE){
            explosions[i].col += explosions[i].cVel;
            if(explosions[i].row <= (-4) || explosions[i].row >= 160 ||
                    explosions[i].col <= (-8) || explosions[i].col >= 240){
                explosions[i].active = INACTIVE;
            }
        }
    }

}

void updateDebris() {
    int i;
    for(i=0; i<MAXASTEROIDS; i++){
        if(asteroids[i].active == ACTIVE){
            asteroids[i].col += asteroids[i].cVel;
            //if goes offscreen
            if(asteroids[i].row <= 0 - asteroids[i].size || asteroids[i].row >= 160 ||
                asteroids[i].col <= 0 - asteroids[i].size){
                asteroids[i].active = INACTIVE;
                if(gameState != PREBOSS) {
                    asteroids[i] = resetAsteroid();
                }
            }
            //if you collide with them, decrease health
            if(
                (player.row+4 >= (asteroids[i].row+(asteroids[i].size/4)) && (player.row+4 <= (asteroids[i].row+asteroids[i].size-(asteroids[i].size/4)))
                && (player.col+12 >= asteroids[i].col+(asteroids[i].size/4)) && player.col+12 <= (asteroids[i].col+(asteroids[i].size-(asteroids[i].size/4))) )
                || ((player.row+player.height-4 >= asteroids[i].row+(asteroids[i].size/4)) && (player.row+player.height-4 <= (asteroids[i].row+asteroids[i].size-(asteroids[i].size/4)))
                && (player.col+player.width-8 >= asteroids[i].col+(asteroids[i].size/4)) && player.col+12 <= (asteroids[i].col+(asteroids[i].size-(asteroids[i].size/4))) )
                || ((player.row+player.height-4 >= asteroids[i].row+(asteroids[i].size/4)) && (player.row+player.height-4 <= (asteroids[i].row+asteroids[i].size-(asteroids[i].size/4)))
                && (player.col+12 >= asteroids[i].col+(asteroids[i].size/4)) && player.col+12 <= (asteroids[i].col+(asteroids[i].size-(asteroids[i].size/4))) )
                || ((player.row+4 >= asteroids[i].row+(asteroids[i].size/4)) && (player.row+4 <= (asteroids[i].row+asteroids[i].size-(asteroids[i].size/4)))
                && (player.col+player.width-8 >= asteroids[i].col+(asteroids[i].size/4)) && player.col+12 <= (asteroids[i].col+(asteroids[i].size-(asteroids[i].size/4))) )

                || ((asteroids[i].row+(asteroids[i].size/4) > player.row+4) && (asteroids[i].row+(asteroids[i].size/4) < player.row+player.height-4)
                && (asteroids[i].col+(asteroids[i].size/4) < player.col+player.width-8) && (asteroids[i].col+(asteroids[i].size/4) > player.col+12) )
                || ((asteroids[i].row+(asteroids[i].size/4) > player.row+4) && (asteroids[i].row+(asteroids[i].size/4) < player.row+player.height-4)
                && (asteroids[i].col+asteroids[i].size+(asteroids[i].size/4) < player.col+player.width-8) && (asteroids[i].col+asteroids[i].size+(asteroids[i].size/4) > player.col+12) )
                || ((asteroids[i].row+asteroids[i].size+(asteroids[i].size/4) > player.row+4) && (asteroids[i].row+asteroids[i].size+(asteroids[i].size/4) < player.row+player.height-4)
                && (asteroids[i].col+asteroids[i].size+(asteroids[i].size/4) < player.col+player.width-8) && (asteroids[i].col+(asteroids[i].size/4) > player.col+12) )
                || ((asteroids[i].row+(asteroids[i].size/4) > player.row+4) && (asteroids[i].row+(asteroids[i].size/4) < player.row+player.height-4)
                && (asteroids[i].col+asteroids[i].size+(asteroids[i].size/4) < player.col+player.width-8) && (asteroids[i].col+(asteroids[i].size/4) > player.col+12) )
                ) {

                int explChoice = rand();
                if (explChoice%3 == 0) {
                    playSoundB(expl01,EXPL01LEN,EXPL01FREQ, 0);
                } else if (explChoice%3 == 1) {
                    playSoundB(expl02,EXPL02LEN,EXPL02FREQ, 0);
                } else {
                    playSoundB(expl03,EXPL03LEN,EXPL03FREQ, 0);
                }
                playerHit(player.row, player.col, true);
                if (!cheating) {
                    player.health--;
                }
                asteroids[i].active = INACTIVE;
                if(gameState != PREBOSS) {
                    asteroids[i] = resetAsteroid();
                }
                //crash noise and player flash
            }
        }
    }

    for(i=0; i<MAXHEALTHPACKS; i++) {
        if(healthPacks[i].active == ACTIVE) {
            healthPacks[i].col += healthPacks[i].cVel;
            //if goes offscreen
            if(healthPacks[i].row+healthPacks[i].size <= 0 || healthPacks[i].row >= 160 ||
                healthPacks[i].col+healthPacks[i].size <= 0 ){
                healthPacks[i].active = INACTIVE;
                collectedHP++;
                if(collectedHP < MAXHEALTHPACKS) {
                    healthPacks[1+i].active = ACTIVE;
                }
            }
            if(player.health < 21) {
                //if you collide with them, increase health
                if( ((player.row+4 >= healthPacks[i].row+4) && (player.row+4 <= (healthPacks[i].row+healthPacks[i].size-4))
                    && (player.col+8 >= healthPacks[i].col+4) && player.col+8 <= (healthPacks[i].col+(healthPacks[i].size-4)) )
                    || ((player.row+player.height-4 >= healthPacks[i].row+4) && (player.row+player.height-4 <= (healthPacks[i].row+healthPacks[i].size-4))
                    && (player.col+player.width-8 >= healthPacks[i].col+4) && player.col+8 <= (healthPacks[i].col+(healthPacks[i].size-4)) )
                    || ((player.row+player.height-4 >= healthPacks[i].row+4) && (player.row+player.height-4 <= (healthPacks[i].row+healthPacks[i].size-4))
                    && (player.col+8 >= healthPacks[i].col+4) && player.col+8 <= (healthPacks[i].col+(healthPacks[i].size-4)) )
                    || ((player.row+4 >= healthPacks[i].row+4) && (player.row+4 <= (healthPacks[i].row+healthPacks[i].size-4))
                    && (player.col+player.width-8 >= healthPacks[i].col+4) && player.col+8 <= (healthPacks[i].col+(healthPacks[i].size-4)) )

                    || ((healthPacks[i].row+4 > player.row+4) && (healthPacks[i].row+4 < player.row+player.height-4)
                    && (healthPacks[i].col+4 < player.col+player.width-8) && (healthPacks[i].col+4 > player.col+8) )
                    || ((healthPacks[i].row+4 > player.row+4) && (healthPacks[i].row+4 < player.row+player.height-4)
                    && (healthPacks[i].col+healthPacks[i].size+4 < player.col+player.width-8) && (healthPacks[i].col+healthPacks[i].size+4 > player.col+8) )
                    || ((healthPacks[i].row+healthPacks[i].size+4 > player.row+4) && (healthPacks[i].row+healthPacks[i].size+4 < player.row+player.height-4)
                    && (healthPacks[i].col+healthPacks[i].size+4 < player.col+player.width-8) && (healthPacks[i].col+4 > player.col+8) )
                    || ((healthPacks[i].row+4 > player.row+4) && (healthPacks[i].row+4 < player.row+player.height-4)
                    && (healthPacks[i].col+healthPacks[i].size+4 < player.col+player.width-8) && (healthPacks[i].col+4 > player.col+8) )
                    ) {

                        playSoundB(Powerup8,POWERUP8LEN,POWERUP8FREQ, 0);
                        player.health++;
                        collectedHP++;
                        health[player.health-1].active = ACTIVE;
                        healthPacks[i].active = INACTIVE;
                        if(collectedHP < 10) {
                            healthPacks[1+i].active = ACTIVE;
                        }
                }

            }
        }
    }
}


void splash() {
    if(BUTTON_PRESSED(BUTTON_START)){
        fillScreen3(BLACK);
        gameState = GAME;
        gamePrep();
        initialize();
        return;
    }
    if(BUTTON_PRESSED(BUTTON_SELECT)){
        fillScreen3(BLACK);
        gameState = HOWTOSCREEN;
        howtoPrep();
        return;
    }
    seed++;
    // Seed random number generator
    srand(seed);

}

void splashPrep() {
    REG_DISPCTL = MODE3| BG2_ENABLE;
    REG_BG0HOFS = 0;
    REG_BG0VOFS = 0;
    REG_BG2HOFS = 0;
    REG_BG2VOFS = 0;
    hOff = 0;
    vOff = 0;
    //reset values to original
    collectedHP = 0;
    howToState = 0;
    bulletTimer = 0;
    bossMoveTimer = 0;
    alertDelay = ALERTDELAYVALUE;
    bossMoveDirIsUp = false;
    cheating = false;
    drawImage3(startBitmap, 0, 0, 240, 240);
    drawString3(20,77,"FLEET DESTROYER", WHITE);
    drawString3(125,77,"Start to begin", WHITE);
    drawString3(140,52,"Select for instructions", WHITE);
}

void howto() {
    if(BUTTON_PRESSED(BUTTON_SELECT)){
        gameState = STARTSCREEN;
        splashPrep();
        return;
    }
    if (player.aniState != PLAYERIDLE) {
        player.prevAniState = player.aniState;
    }
    if(player.aniCounter%20==0) {
        player.aniCounter = 0;
        if (player.currFrame == 2) {
            player.currFrame = 0;
            if(howToState == 0) {
                player.aniState = LEFT;
                howToState++;
            } else if (howToState == 1) {
                player.aniState = FRONT;
                howToState++;
            } else if (howToState == 2) {
                player.aniState = RIGHT;
                howToState++;
            }  else if (howToState == 3) {
                player.aniState = FRONT;
                howToState = 0;
            }
        } else {
            player.currFrame++;
            howToBullet += 10;
            if(howToBullet > 90) {
                howToBullet = 60;
            }
        }
    }
    player.aniCounter++;
    hideSprites();
    shadowOAM[0].attr0 = 3 | ATTR0_4BPP | ATTR0_SQUARE;
    shadowOAM[0].attr1 = 25| ATTR1_SIZE32;
    shadowOAM[0].attr2 = SPRITEOFFSET16(player.currFrame*4, player.prevAniState*4);
    shadowOAM[1].attr0 = 37 | ATTR0_4BPP | ATTR0_SQUARE;
    shadowOAM[1].attr1 = 25| ATTR1_SIZE32;
    shadowOAM[1].attr2 = SPRITEOFFSET16(0,128);
    shadowOAM[2].attr0 = 48 | ATTR0_4BPP | ATTR0_SQUARE;
    shadowOAM[2].attr1 = (howToBullet-5) | ATTR1_SIZE8;
    shadowOAM[2].attr2 = SPRITEOFFSET16(0,173);
    shadowOAM[3].attr0 = 71 | ATTR0_4BPP | ATTR0_SQUARE;
    shadowOAM[3].attr1 = 25| ATTR1_SIZE32;
    shadowOAM[3].attr2 = SPRITEOFFSET16(0,388);
    shadowOAM[4].attr0 = 108 | ATTR0_4BPP | ATTR0_SQUARE;
    shadowOAM[4].attr1 = 33| ATTR1_SIZE16;
    shadowOAM[4].attr2 = (SPRITEOFFSET16(0,460)) | (ATTR2_PALBANK (1));
    DMANow(3, shadowOAM, OAM, 128*4);
    waitForVblank();
}

void howtoPrep() {
    REG_DISPCTL = MODE0 | BG0_ENABLE | BG2_ENABLE | SPRITE_ENABLE;
    REG_BG0CNT = CBB(2) | SBB(25) | BG_SIZE1 | COLOR256;
    loadPalette(howtoPal);
    DMANow(3, howtoTiles, &CHARBLOCKBASE[2], howtoTilesLen/2);
    DMANow(3, howtoMap, &SCREENBLOCKBASE[25], howtoMapLen/2);
    DMANow(3, spritesPal, SPRITE_PALETTE, spritesPalLen/2);
    DMANow(3, spritesTiles, &CHARBLOCKBASE[4], spritesTilesLen/2);
    player.aniCounter = 0;
    player.currFrame = 0;
    player.aniState = FRONT;
}

void pause() {
    if(BUTTON_PRESSED(BUTTON_START)){
        fillScreen3(BLACK);
        gameState = GAME;
        gamePrep();
        unpauseSound();
        return;
    }
    if(BUTTON_PRESSED(BUTTON_SELECT)){
        fillScreen3(BLACK);
        gameState = STARTSCREEN;
        splashPrep();
        stopSound();
        playSoundA(Ballad,BALLADLEN,BALLADFREQ, 1);
        return;
    }

}

void pausePrep() {
    REG_DISPCTL = MODE3| BG2_ENABLE;
    fillScreen3(BLACK);
    drawString3(120,52,"Press Start to continue", WHITE);
    drawString3(140,22,"Press Select to quit to main menu", WHITE);
}

void win() {
    if(BUTTON_PRESSED(BUTTON_START)){
        fillScreen3(BLACK);
        gameState = STARTSCREEN;
        splashPrep();
        stopSound();
        playSoundA(Ballad,BALLADLEN,BALLADFREQ, 1);
        return;
    }
}

void winPrep() {
    REG_DISPCTL = MODE3| BG2_ENABLE;
    fillScreen3(BLACK);
    drawString3(70,69,"VICTORY IS YOURS", WHITE);
    drawString3(140,18,"Press Start to return to main menu", WHITE);
}

void lose() {
    if(BUTTON_PRESSED(BUTTON_START)){
        fillScreen3(BLACK);
        gameState = STARTSCREEN;
        splashPrep();
        stopSound();
        playSoundA(Ballad,BALLADLEN,BALLADFREQ, 1);
        return;
    }
}

void losePrep() {
    REG_DISPCTL = MODE3| BG2_ENABLE;
    fillScreen3(BLACK);
    drawString3(70,53,"YOUR SHIP WAS DESTROYED", WHITE);
    drawString3(140,17,"Press Start to return to main menu", WHITE);
}

void alwaysCallThese() {
    hideSprites();
    player.bigRow = player.row + vOff;
    player.bigCol = player.col + hOff;
    REG_BG0HOFS = hOff;
    REG_BG0VOFS = vOff;
    REG_BG2HOFS = hOff/2;
    REG_BG2VOFS = vOff/2;
    if(BUTTON_HELD(BUTTON_UP)) {
        if(player.row > 0) {
            player.row--;
        } else {
            player.row = 0;
        }
    }
    if(BUTTON_HELD(BUTTON_DOWN)) {
        if(player.row < (160 - player.height)) {
            player.row++;
        } else {
            player.row = 160 - player.height;
        }
    }
    if(BUTTON_HELD(BUTTON_LEFT)) {
        if(player.col > 0) {
            player.col--;
            player.col--;
        } else {
            player.col = 0;
        }
    }
    if(BUTTON_HELD(BUTTON_RIGHT)) {
        if(player.col < (240 - player.width)) {
            player.col++;
        } else {
            player.col = (240 - player.width);
        }
    }
    if(BUTTON_PRESSED(BUTTON_START)) {
        gameState = PAUSESCREEN;
        pausePrep();
        pauseSound();
        return;
    }
    if(BUTTON_PRESSED(BUTTON_B)) {
        shoot();
        return;
    }
    if(BUTTON_PRESSED(BUTTON_A)) {
        cheat();
        return;
    }
    if(player.health <= 0){
        gameState = LOSESCREEN;
        losePrep();
        stopSound();
        playSoundB(longCrash,LONGCRASHLEN,LONGCRASHFREQ, 0);
        return;
    }
    animate();
    updateOAM();
    updateBullets();
    updateDebris();
    DMANow(3, shadowOAM, OAM, 128*4);
    waitForVblank();
}

void setupAsteroidTypes() {
    asteroidType[0].row = 50;
    asteroidType[0].col = 300;
    asteroidType[0].cVel = -1;
    asteroidType[0].size = 32;
    asteroidType[0].active = ACTIVE;
    asteroidType[0].health = 2;
    asteroidType[0].type = 0;
    asteroidType[0].spriteSheetY = 384;
    asteroidType[0].spriteSizeAttr = ATTR1_SIZE32;

    asteroidType[1].row = 50;
    asteroidType[1].col = 300;
    asteroidType[1].cVel = -1;
    asteroidType[1].size = 32;
    asteroidType[1].active = ACTIVE;
    asteroidType[1].health = 2;
    asteroidType[1].type = 1;
    asteroidType[1].spriteSheetY = 388;
    asteroidType[1].spriteSizeAttr = ATTR1_SIZE32;

    asteroidType[2].row = 50;
    asteroidType[2].col = 300;
    asteroidType[2].cVel = -1;
    asteroidType[2].size = 32;
    asteroidType[2].active = ACTIVE;
    asteroidType[2].health = 2;
    asteroidType[2].type = 2;
    asteroidType[2].spriteSheetY = 392;
    asteroidType[2].spriteSizeAttr = ATTR1_SIZE32;

    asteroidType[3].row = 50;
    asteroidType[3].col = 300;
    asteroidType[3].cVel = -1;
    asteroidType[3].size = 16;
    asteroidType[3].active = ACTIVE;
    asteroidType[3].health = 1;
    asteroidType[3].type = 3;
    asteroidType[3].spriteSheetY = 396;
    asteroidType[3].spriteSizeAttr = ATTR1_SIZE16;

    asteroidType[4].row = 50;
    asteroidType[4].col = 300;
    asteroidType[4].cVel = -1;
    asteroidType[4].size = 64;
    asteroidType[4].active = ACTIVE;
    asteroidType[4].health = 3;
    asteroidType[4].type = 4;
    asteroidType[4].spriteSheetY = 512;
    asteroidType[4].spriteSizeAttr = ATTR1_SIZE64;

    asteroidType[5].row = 50;
    asteroidType[5].col = 300;
    asteroidType[5].cVel = -1;
    asteroidType[5].size = 64;
    asteroidType[5].active = ACTIVE;
    asteroidType[5].health = 3;
    asteroidType[5].type = 5;
    asteroidType[5].spriteSheetY = 768;
    asteroidType[5].spriteSizeAttr = ATTR1_SIZE64;
}

HOSTILE resetAsteroid() {
    HOSTILE asteroid = asteroidType[(rand()%6)];
    asteroid.size = asteroid.size;
    asteroid.row = rand()%(160-(asteroid.size/2));
    asteroid.col = (rand()%240)+223;
    asteroid.cVel = asteroid.cVel;
    asteroid.health = asteroid.health;
    asteroid.type = asteroid.type;
    asteroid.spriteSheetY = asteroid.spriteSheetY;
    asteroid.spriteSizeAttr = asteroid.spriteSizeAttr;
    asteroid.active = ACTIVE;
    return asteroid;
}
