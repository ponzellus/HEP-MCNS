# NAME

HEP::MCNS - converts HEP MC numbers into particle names

# VERSION

version 0.01

# SYNOPSIS

        use HEP::MCNS 'particle_name';
        my $electron_name = particle_name( 11 );
        my $bzero_name = particle_name( 511 );

# DESCRIPTION

The [Monte Carlo Numbering Scheme](http://pdg.lbl.gov/2014/reviews/rpp2014-rev-monte-carlo-numbering.pdf) assigns a unique identifier to each particle.
This module converts those numbers into readable particle names.

If any number is missing/wrong, please file an issue.

LaTeX output is planned but not yet implemented

# FUNCTIONS

## particle\_name()

takes the Monte Carlo number as input and prints the particle name 

# AUTHOR

Philipp Hamer <philha@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Philipp Hamer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
