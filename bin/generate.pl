#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;

use FindBin;
use lib $FindBin::Dir . "/../lib";

use DDH::UserPage::Gather;
use DDH::UserPage::Generate;

DDH::UserPage::Generate->new(
    contributors => DDH::UserPage::Gather->new->contributors,
    view_dir     => "$FindBin::Dir/../views",
    build_dir    => "/home/ddgc/ddgc/ddh-userpages"
)->generate;

