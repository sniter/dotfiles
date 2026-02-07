static const char norm_fg[] = "#dde0e2";
static const char norm_bg[] = "#0C292D";
static const char norm_border[] = "#9a9c9e";

static const char sel_fg[] = "#dde0e2";
static const char sel_bg[] = "#6398A2";
static const char sel_border[] = "#dde0e2";

static const char urg_fg[] = "#dde0e2";
static const char urg_bg[] = "#3F9AAE";
static const char urg_border[] = "#3F9AAE";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
