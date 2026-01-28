const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#020207", /* black   */
  [1] = "#5D3858", /* red     */
  [2] = "#214872", /* green   */
  [3] = "#A04659", /* yellow  */
  [4] = "#1F5B98", /* blue    */
  [5] = "#4F6DA3", /* magenta */
  [6] = "#B2738C", /* cyan    */
  [7] = "#a6bed7", /* white   */

  /* 8 bright colors */
  [8]  = "#748596",  /* black   */
  [9]  = "#5D3858",  /* red     */
  [10] = "#214872", /* green   */
  [11] = "#A04659", /* yellow  */
  [12] = "#1F5B98", /* blue    */
  [13] = "#4F6DA3", /* magenta */
  [14] = "#B2738C", /* cyan    */
  [15] = "#a6bed7", /* white   */

  /* special colors */
  [256] = "#020207", /* background */
  [257] = "#a6bed7", /* foreground */
  [258] = "#a6bed7",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
