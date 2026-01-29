static const char norm_fg[] = "#9ca7b5";
static const char norm_bg[] = "#000514";
static const char norm_border[] = "#6d747e";

static const char sel_fg[] = "#9ca7b5";
static const char sel_bg[] = "#243851";
static const char sel_border[] = "#9ca7b5";

static const char urg_fg[] = "#9ca7b5";
static const char urg_bg[] = "#192E47";
static const char urg_border[] = "#192E47";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
