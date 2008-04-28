package Moxy::Plugin::DisplayWidth;
use strict;
use warnings;
use base qw/Moxy::Plugin/;

# HTML全体の横幅をUAの画面サイズに合わせる
sub response_filter:Hook('response_filter') {
    my ($class, $context, $args) = @_;
    return if $args->{mobile_attribute}->is_non_mobile;
    return if $args->{mobile_attribute}->is_airh_phone;

    my $display = $args->{mobile_attribute}->display;
    my $header = sprintf(
        q{<div style="border: 1px black solid; width: %dpx; margin: 0 auto;float: left;">}, $display->width
    );

    my $content = $args->{response}->content;
    $content =~ s!(<body[^>]*>)!$1$header!i;
    $content =~ s!(</body>)!"</div>$1"!ie;
    $args->{response}->content($content);
}

1;
__END__

=for stopwords localsrc HTML

=head1 NAME

Moxy::Plugin::DisplayWidth - limit the HTML width

=head1 SYNOPSIS

  - module: HTMLWidth

=head1 DESCRIPTION

limit the HTML width

=head1 AUTHOR

Kan Fushihara

Tokuhiro Matsuno

=head1 SEE ALSO

L<Moxy>
