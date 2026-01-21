static const char norm_fg[] = "#94c7d4";
static const char norm_bg[] = "#020817";
static const char norm_border[] = "#678b94";

static const char sel_fg[] = "#94c7d4";
static const char sel_bg[] = "#B07F3D";
static const char sel_border[] = "#94c7d4";

static const char urg_fg[] = "#94c7d4";
static const char urg_bg[] = "#574648";
static const char urg_border[] = "#574648";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
