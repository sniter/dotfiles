const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0C292D", /* black   */
  [1] = "#3F9AAE", /* red     */
  [2] = "#6398A2", /* green   */
  [3] = "#96ABAE", /* yellow  */
  [4] = "#C2B9AC", /* blue    */
  [5] = "#9BBAC6", /* magenta */
  [6] = "#AFC8CE", /* cyan    */
  [7] = "#dde0e2", /* white   */

  /* 8 bright colors */
  [8]  = "#9a9c9e",  /* black   */
  [9]  = "#3F9AAE",  /* red     */
  [10] = "#6398A2", /* green   */
  [11] = "#96ABAE", /* yellow  */
  [12] = "#C2B9AC", /* blue    */
  [13] = "#9BBAC6", /* magenta */
  [14] = "#AFC8CE", /* cyan    */
  [15] = "#dde0e2", /* white   */

  /* special colors */
  [256] = "#0C292D", /* background */
  [257] = "#dde0e2", /* foreground */
  [258] = "#dde0e2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
