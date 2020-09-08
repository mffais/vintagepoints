#!/usr/bin/perl 
use strict;

print "Hello, World!\n";

my @files = glob( '*.html' );

for my $file (@files) {
    fix($file);
}


sub fix {
    my $filename = shift;

    print "Parse $filename\n";
    
    open (FH, '<', $filename) or die "Unable to open file, $!";

    my $html = '';
    while (my $line = <FH>) {
      # chomp $row;
      $html .= $line;
    }

    close FH;


    my $from = q{<div style="position: absolute; top:0px; left:0px;  background-color: yellow; color:black; width: 100%;">
    These pages were formerly located at: www.vintagepointsblog.com};
    my $to   = q{<div style="position: absolute; top:0px; left:0px; background-color: yellow; color:black; width: 100%; z-index:10;">
    These pages were formerly located at: www.vintagepointsblog.com};
    $html =~ s/$from/$to/;

    my $from = q{<header id="masthead" class="sheader site-header clearfix">};
    my $to   = q{<header id="masthead" class="sheader site-header clearfix" style="margin-top: 25px;">};
    $html =~ s/$from/$to/;

    my $from = q{<script type='text/javascript' src='\.\./s0\.wp\.com/wp-content/js/devicepx-jetpack3119\.js\?ver=202035'></script>};
    my $to   = q{};
    $html =~ s/$from/$to/;

    my $from = q{<script type='text/javascript' src='\.\./s\.gravatar.com/js/gprofileseca6\.js\?ver=2020Augaa'></script>};
    my $to   = q{<script type='text/javascript' src='https://s.gravatar.com/js/gprofileseca6.js?ver=2020Augaa'></script>};
    $html =~ s/$from/$to/;

    my $from = q{<script type='text/javascript' src='\.\./stats\.wp\.com/e-202035\.js' async defer></script>};
    my $to   = q{<script type='text/javascript' src='https://stats.wp.com/e-202035.js' async defer></script>};
    $html =~ s/$from/$to/;

    my $from = q{http:\\\\/\\\\/www\.vintagepointsblog\.com\\\\/wp-includes\\\\/js\\\\/wp-emoji-release\.min\.js\?ver=5\.4\.2};
    my $to   = q{wp-includes\\/js\\/wp-emoji-release.min.js?ver=5.4.2};
    $html =~ s/$from/$to/;

    my $from = q{\.\./www\.google-analytics\.com/analytics\.js};
    my $to   = q{https://www\.google-analytics\.com/analytics\.js};
    $html =~ s/$from/$to/;

    my $from = q{These pages were formerly located at: www.vintagepointsblog.com};
    my $to   = q{This site will be located at: www.5thstreetchronicles.com/vintagepointsblog from 20 May 2021. There will be no further updates henceforth.};
    $html =~ s/$from/$to/;

    open(FH, '>', $filename) or die $!;

    print FH $html;

    close FH;
}
