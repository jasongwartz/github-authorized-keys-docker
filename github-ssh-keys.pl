### github-ssh-keys ###

use warnings;
use strict;

use LWP::UserAgent; # make sure to also install LWP::Protocol::https
use Data::Dumper;
use JSON;

die "Must provide the 'SLEEP_TIME' env var." unless $ENV{ SLEEP_TIME };
die "Must provide the 'GITHUB_USER' env var." unless $ENV{ GITHUB_USER };

sub get_and_store_keys {

    my $ua = LWP::UserAgent->new;

    my $github_user = $ENV{ GITHUB_USER };

    my $json_keys = $ua->get("https://api.github.com/users/$github_user/keys")->decoded_content;
    return unless defined $json_keys;

    my $decoded = decode_json($json_keys);
    print "Rate limited\n" and return if index($decoded->{ message }, "limit exceeded");

    my @keys = map { $_->{ key } } @{ $decoded };
    my $authorized_keys = join("\n", @keys);

    mkdir $ENV{ HOME } . "/.ssh";
    my $filename = $ENV{ HOME } . "/.ssh/authorized_keys";

    open(my $fh, '>', $filename) or die "Couldn't open authorized_keys file:\n\t$!";

    print $fh $authorized_keys;
    close $fh;

    print "Wrote ssh keys for $github_user to $filename.\n";
}

while ( 1 ) {
    my $t = localtime;
    print "$t", "\t| Starting request.\n";
    get_and_store_keys;
    sleep $ENV{ SLEEP_TIME };
}
