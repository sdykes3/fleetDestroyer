
//{{BLOCK(starsBig)

//======================================================================
//
//	starsBig, 512x256@8, 
//	+ palette 256 entries, not compressed
//	+ 32 tiles (t|f|p reduced) not compressed
//	+ regular map (in SBBs), not compressed, 64x32 
//	Total size: 512 + 2048 + 4096 = 6656
//
//	Time-stamp: 2014-10-21, 17:55:37
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_STARSBIG_H
#define GRIT_STARSBIG_H

#define starsBigTilesLen 2048
extern const unsigned short starsBigTiles[1024];

#define starsBigMapLen 4096
extern const unsigned short starsBigMap[2048];

#define starsBigPalLen 512
extern const unsigned short starsBigPal[256];

#endif // GRIT_STARSBIG_H

//}}BLOCK(starsBig)
