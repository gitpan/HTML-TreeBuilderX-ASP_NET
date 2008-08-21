use HTML::TreeBuilderX::ASP_NET;
use HTML::TreeBuilder;
use Test::More tests => 4;

my $html = q{
	<form method="post" action="server.aspx">
	<a href="javascript:__doPostBack('next', '')"> foo </a>
	</form>
};

{
	my $aspnet = HTML::TreeBuilderX::ASP_NET->new;
	can_ok( $aspnet, 'httpRequest' );
}

eval { HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] ) };
ok ( !$@, 'htmlElement trait construction is good!!' );

eval {
	HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] );
	$req = HTML::Element->new('a', href => "__doPostBack('foo','bar')" )->httpRequest;
};
like ( $@, qr/<form>/, 'Success with use! (failed without the parent form)' );

{
	my $req;
	HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] );
	$req = HTML::TreeBuilder
		->new_from_content($html)
		->look_down( '_tag' => 'a' )
		->httpRequest
	;
	is ( ref $req, 'HTTP::Request', 'Success with use! (type)' );
}

1;
