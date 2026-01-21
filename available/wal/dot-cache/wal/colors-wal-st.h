const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#020817", /* black   */
  [1] = "#574648", /* red     */
  [2] = "#B07F3D", /* green   */
  [3] = "#17438B", /* yellow  */
  [4] = "#03508E", /* blue    */
  [5] = "#156498", /* magenta */
  [6] = "#026EA9", /* cyan    */
  [7] = "#94c7d4", /* white   */

  /* 8 bright colors */
  [8]  = "#678b94",  /* black   */
  [9]  = "#574648",  /* red     */
  [10] = "#B07F3D", /* green   */
  [11] = "#17438B", /* yellow  */
  [12] = "#03508E", /* blue    */
  [13] = "#156498", /* magenta */
  [14] = "#026EA9", /* cyan    */
  [15] = "#94c7d4", /* white   */

  /* special colors */
  [256] = "#020817", /* background */
  [257] = "#94c7d4", /* foreground */
  [258] = "#94c7d4",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
