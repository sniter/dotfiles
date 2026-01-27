const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#010101", /* black   */
  [1] = "#77C0DE", /* red     */
  [2] = "#6DCFF6", /* green   */
  [3] = "#999998", /* yellow  */
  [4] = "#FDC689", /* blue    */
  [5] = "#D4C9AB", /* magenta */
  [6] = "#AACFD4", /* cyan    */
  [7] = "#ebecea", /* white   */

  /* 8 bright colors */
  [8]  = "#a4a5a3",  /* black   */
  [9]  = "#77C0DE",  /* red     */
  [10] = "#6DCFF6", /* green   */
  [11] = "#999998", /* yellow  */
  [12] = "#FDC689", /* blue    */
  [13] = "#D4C9AB", /* magenta */
  [14] = "#AACFD4", /* cyan    */
  [15] = "#ebecea", /* white   */

  /* special colors */
  [256] = "#010101", /* background */
  [257] = "#ebecea", /* foreground */
  [258] = "#ebecea",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
