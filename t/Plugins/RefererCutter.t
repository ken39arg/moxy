use strict;
use warnings;
use Moxy::Plugin::RefererCutter;
use Moxy;
use HTTP::Request;
use Test::More tests => 2;
use HTTP::Session::State::Test;
use HTTP::Session::Store::Test;
use CGI;

Moxy->load_plugins(qw/RefererCutter/);
my $m = Moxy->new();
my $req = HTTP::Request->new();
$req->header('Referer' => 'http://wassr.jp/');
$req->header('X-Moe' => 'nishiohirokazu');
$m->run_hook(
    'request_filter' => {
        request => $req,
        session => HTTP::Session->new(
            state => HTTP::Session::State::Test->new(
                session_id => 'fkldsaaljasdfafaa',
            ),
            store   => HTTP::Session::Store::Test->new,
            request => CGI->new(),
        ),
        mobile_attribute => HTTP::MobileAttribute->new($req->headers),
    }
);
is $req->header('X-Moe') => 'nishiohirokazu';
ok !$req->header('Referer');

