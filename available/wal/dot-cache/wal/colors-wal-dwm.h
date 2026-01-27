static const char norm_fg[] = "#ebecea";
static const char norm_bg[] = "#010101";
static const char norm_border[] = "#a4a5a3";

static const char sel_fg[] = "#ebecea";
static const char sel_bg[] = "#6DCFF6";
static const char sel_border[] = "#ebecea";

static const char urg_fg[] = "#ebecea";
static const char urg_bg[] = "#77C0DE";
static const char urg_border[] = "#77C0DE";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
