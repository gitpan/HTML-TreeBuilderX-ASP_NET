package HTML::TreeBuilderX::ASP_NET::Roles::htmlElement;
use Moose::Role;

Moose::init_meta( 'HTML::Element' );

sub BUILD {
	my $self = shift;
	
	Class::MOP::load_class('HTML::TreeBuilderX::ASP_NET');
	HTML::Element->meta->add_method('httpRequest', sub {
		my $self = shift;
		HTML::TreeBuilderX::ASP_NET->new({ element=> $self })->httpRequest;
	});

}

1;

__END__

=head1 NAME

HTML::TreeBuilderX::ASP_NET::Roles::htmlElement -- An easy hack for HTML::Element

=head1 DESCRPITION

A simple 15 line module with a nicer more transparent API.

=head1 SYNOPSIS

	HTML::TreeBuilderX::ASP_NET->new_with_traits( traits => ['htmlElement'] );

	## returns a HTTP::Request for the form
	$root->look_down( '_tag' => 'a' )->httpRequest;

=head1 SEE ALSO

B<FOR ALL DOCS>

L<HTML::TreeBuilderX::ASP_NET>
