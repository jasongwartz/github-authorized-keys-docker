### github-ssh-keys ###

# Add the following line to the user's crontab:
#     0 * * * * perl $PATH_TO/github-ssh-keys.pl <GITHUB_USERNAME>
# Eg. for me:
#     0 * * * * perl /home/jasongwartz/github-ssh-key.pl jasongwartz
# You can set the keys file to a location other than ~/.ssh/authorized_keys by overriding the $HOME environment variable:
#     0 * * * * HOME=<SOME_DIR> 

use warnings;
use strict;

use LWP::Simple; # make sure to also install LWP::Protocol::https
use Data::Dumper;
use JSON;

use LWP::UserAgent;
my $ua = LWP::UserAgent->new;

my $github_user = $ENV{ GITHUB_USER } // $ARGV[0] // die "Need to specify a github user.";

my $json_keys = $ua->get("https://api.github.com/users/$github_user/keys")->decoded_content;
die "Couldn't get keys." unless defined $json_keys;

my @keys = map { $_->{ key } } @{ decode_json($json_keys) };
my $authorized_keys = join("\n", @keys);

my $filename = $ENV{ HOME } . "/.ssh/authorized_keys";
open(my $fh, '>', $filename) or die "Couldn't open authorized_keys file:\n\t$!";

print $fh $authorized_keys;
close $fh;

print "Wrote ssh keys for $github_user to $filename.\n";
