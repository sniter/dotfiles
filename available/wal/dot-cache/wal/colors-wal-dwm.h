static const char norm_fg[] = "#a6bed7";
static const char norm_bg[] = "#020207";
static const char norm_border[] = "#748596";

static const char sel_fg[] = "#a6bed7";
static const char sel_bg[] = "#214872";
static const char sel_border[] = "#a6bed7";

static const char urg_fg[] = "#a6bed7";
static const char urg_bg[] = "#5D3858";
static const char urg_border[] = "#5D3858";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
