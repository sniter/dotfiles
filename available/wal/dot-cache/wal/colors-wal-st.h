const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#000514", /* black   */
  [1] = "#192E47", /* red     */
  [2] = "#243851", /* green   */
  [3] = "#2D425C", /* yellow  */
  [4] = "#344C67", /* blue    */
  [5] = "#44454F", /* magenta */
  [6] = "#445B76", /* cyan    */
  [7] = "#9ca7b5", /* white   */

  /* 8 bright colors */
  [8]  = "#6d747e",  /* black   */
  [9]  = "#192E47",  /* red     */
  [10] = "#243851", /* green   */
  [11] = "#2D425C", /* yellow  */
  [12] = "#344C67", /* blue    */
  [13] = "#44454F", /* magenta */
  [14] = "#445B76", /* cyan    */
  [15] = "#9ca7b5", /* white   */

  /* special colors */
  [256] = "#000514", /* background */
  [257] = "#9ca7b5", /* foreground */
  [258] = "#9ca7b5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
