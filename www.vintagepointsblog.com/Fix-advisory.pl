#!/usr/bin/perl 
use strict;

print "Hello, World!\n";

# Rebuild try

# my @files = glob( '*.html' );

#for my $file (@files) {
#    fix($file);
#}


#fix("index.html");
#exit(0);

dir_listing('.');

my @paths;
sub dir_listing {
    my ($root) = @_;
    $root .= '/' unless $root =~ /\/$/;
    for my $f (glob "$root*"){
        push @paths, $f;
        dir_listing($f) if -d $f;
    }
    return @paths;
}

for my $rec (@paths) {
    if ($rec =~ /\.html$/) {
        # print "$rec\n";
        fix($rec);
    }
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


    my $from = q{This site will be located at: www\.5thstreetchronicles\.com/vintagepointsblog from 20 May 2021\. There will be no further updates henceforth\.};
    my $to   = q{This site is in the process of moving and access by phone will not provide the optimum viewing experience.
It will be located at: www.5thstreetchronicles.com/vintagepointsblog from 20 May 2021. There will be no further updates henceforth.
Purchase information for hard copy of articles previously published, please contact: info@5thstreetchronicles.com.};
    $html =~ s/$from/$to/g;

    my $from = q{<header id="masthead" class="sheader site-header clearfix" style="margin-top: 25px;">};
    my $to   = q{<header id="masthead" class="sheader site-header clearfix" style="margin-top: 52px;">};
    $html =~ s/$from/$to/g;


    # $filename = "index-1.html";
    open(FH, '>', $filename) or die $!;

    print FH $html;

    close FH;
}
