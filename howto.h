
//{{BLOCK(howto)

//======================================================================
//
//	howto, 256x256@8, 
//	+ palette 256 entries, not compressed
//	+ 104 tiles (t|f|p reduced) not compressed
//	+ regular map (in SBBs), not compressed, 32x32 
//	Total size: 512 + 6656 + 2048 = 9216
//
//	Time-stamp: 2014-11-10, 17:36:55
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_HOWTO_H
#define GRIT_HOWTO_H

#define howtoTilesLen 6656
extern const unsigned short howtoTiles[3328];

#define howtoMapLen 2048
extern const unsigned short howtoMap[1024];

#define howtoPalLen 512
extern const unsigned short howtoPal[256];

#endif // GRIT_HOWTO_H

//}}BLOCK(howto)
