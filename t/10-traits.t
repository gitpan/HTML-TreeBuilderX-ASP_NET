use HTML::TreeBuilderX::ASP_NET;
use Test::More tests => 2;

eval { HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] ) };
ok ( !$@, 'htmlElement trait construction is good!!' );

eval {
	HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] );
	my $req = HTML::Element->new('a', href => "__doPostBack('foo','bar')" )->httpRequest;
};
like ( $@, qr/<form>/, 'Success with use!' );

1;
