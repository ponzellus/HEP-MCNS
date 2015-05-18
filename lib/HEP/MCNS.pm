use strict;
use warnings;

package HEP::MCNS;

# ABSTRACT: converts HEP MC numbers into particle names and vice versa

=head1 SYNOPSIS

	use HEP::MCNS qw(particle_name particle_code);
	my $electron_name = particle_name( 11 );
	my $bzero_name = particle_name( 511 );
	my $bplus_code = particle_code( 'B+' );
	my $dstar_code = particle_code( 'D*0' );


=head1 DESCRIPTION

The L<Monte Carlo Numbering Scheme|http://pdg.lbl.gov/2014/reviews/rpp2014-rev-monte-carlo-numbering.pdf> assigns a unique identifier to each particle.
This module converts those numbers into readable particle names and vice versa.

If any number is missing/wrong, please file an issue.

LaTeX output is planned but not yet implemented

=cut

use Exporter qw( import );

our @EXPORT_OK = qw( particle_name particle_code );

my %particles = (

	0 => "-",
	1 => "d",
	-1 => "anti-d",
	2 => "u",
	-2 => "anti-u",
	3 => "s",
	-3 => "anti-s",
	4 => "c",
	-4 => "anti-c",
	5 => "b",
	-5 => "anti-b",
	6 => "t",
	-6 => "anti-t",
	7 => "b'",
	-7 => "anti-b'",
	8 => "t'",
	-8 => "anti-t'",
	11 => "e-",
	-11 => "e+",
	12 => "nu_e",
	-12 => "anti-nu_e",
	13 => "mu-",
	-13 => "mu+",
	14 => "nu_mu",
	-14 => "anti-nu_mu",
	15 => "tau-",
	-15 => "tau+",
	16 => "nu_tau",
	-16 => "anti-nu_tau",
	17 => "L-",
	-17 => "L+",
	18 => "nu_L",
	-18 => "anti-nu_L",
	21 => "g",
	22 => "gamma",
	10022 => "vpho",
	20022 => "Cerenkov",
	30022 => "radgam",
	23 => "Z0",
	24 => "W+",
	-24 => "W-",
	25 => "Higgs0",
	110 => "reggeon",
	990 => "pomeron",
	32 => "Z'0",
	33 => "Z''0",
	34 => "W'+",
	-34 => "W'-",
	35 => "Higgs'0",
	36 => "A0",
	37 => "Higgs+",
	-37 => "Higgs-",
	41 => "R0",
	-41 => "anti-R0",
	61 => "Xu0",
	62 => "Xu+",
	-62 => "Xu-",
	81 => "specflav",
	82 => "rndmflav",
	-82 => "anti-rndmflav",
	83 => "phasespa",
	84 => "c-hadron",
	-84 => "anti-c-hadron",
	85 => "b-hadron",
	-85 => "anti-b-hadron",
	86 => "t-hadron",
	-86 => "anti-t-hadron",
	87 => "b'-hadron",
	-87 => "anti-b'-hadron",
	88 => "t'-hadron",
	-88 => "anti-t'-hadron",
	89 => "Wvirt+",
	-89 => "Wvirt-",
	90 => "diquark",
	-90 => "anti-diquark",
	91 => "cluster",
	92 => "string",
	93 => "indep",
	94 => "CMshower",
	95 => "SPHEaxis",
	96 => "THRUaxis",
	97 => "CLUSjet",
	98 => "CELLjet",
	99 => "table",
	100 => "geantino",
	1101 => "dd_0",
	-1101 => "anti-dd_0",
	2101 => "ud_0",
	-2101 => "anti-ud_0",
	2201 => "uu_0",
	-2201 => "anti-uu_0",
	3101 => "sd_0",
	-3101 => "anti-sd_0",
	3201 => "su_0",
	-3201 => "anti-su_0",
	3301 => "ss_0",
	-3301 => "anti-ss_0",
	4101 => "cd_0",
	-4101 => "anti-cd_0",
	4201 => "cu_0",
	-4201 => "anti-cu_0",
	4301 => "cs_0",
	-4301 => "anti-cs_0",
	4401 => "cc_0",
	-4401 => "anti-cc_0",
	5101 => "bd_0",
	-5101 => "anti-bd_0",
	5201 => "bu_0",
	-5201 => "anti-bu_0",
	5301 => "bs_0",
	-5301 => "anti-bs_0",
	5401 => "bc_0",
	-5401 => "anti-bc_0",
	5501 => "bb_0",
	-5501 => "anti-bb_0",
	1103 => "dd_1",
	-1103 => "anti-dd_1",
	2103 => "ud_1",
	-2103 => "anti-ud_1",
	2203 => "uu_1",
	-2203 => "anti-uu_1",
	3103 => "sd_1",
	-3103 => "anti-sd_1",
	3203 => "su_1",
	-3203 => "anti-su_1",
	3303 => "ss_1",
	-3303 => "anti-ss_1",
	4103 => "cd_1",
	-4103 => "anti-cd_1",
	4203 => "cu_1",
	-4203 => "anti-cu_1",
	4303 => "cs_1",
	-4303 => "anti-cs_1",
	4403 => "cc_1",
	-4403 => "anti-cc_1",
	5103 => "bd_1",
	-5103 => "anti-bd_1",
	5203 => "bu_1",
	-5203 => "anti-bu_1",
	5303 => "bs_1",
	-5303 => "anti-bs_1",
	5403 => "bc_1",
	-5403 => "anti-bc_1",
	5503 => "bb_1",
	-5503 => "anti-bb_1",
	9910113 => "rho_diff0",
	9910211 => "pi_diff+",
	-9910211 => "pi_diff-",
	9910223 => "omega_diff",
	9910333 => "phi_diff",
	9910443 => "psi_diff",
	9912112 => "n_diffr",
	-9912112 => "anti-n_diffr",
	9912212 => "p_diff+",
	-9912212 => "anti-p_diff-",
	1011 => "deuteron",
	-1011 => "anti-deuteron",
	1021 => "tritium",
	-1021 => "anti-tritium",
	1012 => "He3",
	-1012 => "anti-He3",
	1022 => "alpha",
	-1022 => "anti-alpha",
	111 => "pi0",
	211 => "pi+",
	-211 => "pi-",
	10111 => "a_00",
	10211 => "a_0+",
	-10211 => "a_0-",
	100111 => "pi(2S)0",
	100211 => "pi(2S)+",
	-100211 => "pi(2S)-",
	113 => "rho0",
	213 => "rho+",
	-213 => "rho-",
	10113 => "b_10",
	10213 => "b_1+",
	-10213 => "b_1-",
	20113 => "a_10",
	20213 => "a_1+",
	-20213 => "a_1-",
	100113 => "rho(2S)0",
	100213 => "rho(2S)+",
	-100213 => "rho(2S)-",
	30113 => "rho(3S)0",
	30213 => "rho(3S)+",
	-30213 => "rho(3S)-",
	115 => "a_20",
	215 => "a_2+",
	-215 => "a_2-",
	9000221 => "f_0(600)",
	221 => "eta",
	331 => "eta'",
	10221 => "f_0",
	100221 => "eta(2S)",
	10331 => "f'_0",
	9020221 => "eta(1405)",
	9030221 => "f_0(1500)",
	223 => "omega",
	333 => "phi",
	10223 => "h_1",
	20223 => "f_1",
	10333 => "h'_1",
	20333 => "f'_1",
	100223 => "omega(2S)",
	100333 => "phi(1680)",
	225 => "f_2",
	335 => "f'_2",
	310 => "K_S0",
	130 => "K_L0",
	311 => "K0",
	-311 => "anti-K0",
	321 => "K+",
	-321 => "K-",
	90000311 => "K_0*(800)0",
	-90000311 => "anti-K_0*(800)0",
	90000321 => "K_0*(800)+",
	-90000321 => "K_0*(800)-",
	10311 => "K_0*0",
	-10311 => "anti-K_0*0",
	10321 => "K_0*+",
	-10321 => "K_0*-",
	30343 => "Xsd",
	-30343 => "anti-Xsd",
	30353 => "Xsu",
	-30353 => "anti-Xsu",
	30363 => "Xss",
	-30363 => "anti-Xss",
	30643 => "Xdd",
	-30643 => "anti-Xdd",
	30653 => "Xdu+",
	-30653 => "anti-Xdu-",
	313 => "K*0",
	-313 => "anti-K*0",
	323 => "K*+",
	-323 => "K*-",
	10313 => "K_10",
	-10313 => "anti-K_10",
	10323 => "K_1+",
	-10323 => "K_1-",
	20313 => "K'_10",
	-20313 => "anti-K'_10",
	20323 => "K'_1+",
	-20323 => "K'_1-",
	100313 => "K'*0",
	-100313 => "anti-K'*0",
	100323 => "K'*+",
	-100323 => "K'*-",
	30313 => "K''*0",
	-30313 => "anti-K''*0",
	30323 => "K''*+",
	-30323 => "K''*-",
	315 => "K_2*0",
	-315 => "anti-K_2*0",
	325 => "K_2*+",
	-325 => "K_2*-",
	10315 => "K_2(1770)0",
	-10315 => "anti-K_2(1770)0",
	10325 => "K_2(1770)+",
	-10325 => "K_2(1770)-",
	20315 => "K_2(1820)0",
	-20315 => "anti-K_2(1820)0",
	20325 => "K_2(1820)+",
	-20325 => "K_2(1820)-",
	317 => "K_3*0",
	-317 => "anti-K_3*0",
	327 => "K_3*+",
	-327 => "K_3*-",
	319 => "K_4*0",
	-319 => "anti-K_4*0",
	329 => "K_4*+",
	-329 => "K_4*-",
	411 => "D+",
	-411 => "D-",
	421 => "D0",
	-421 => "anti-D0",
	10411 => "D_0*+",
	-10411 => "D_0*-",
	10421 => "D_0*0",
	-10421 => "anti-D_0*0",
	100411 => "D(2S)+",
	-100411 => "D(2S)-",
	100421 => "D(2S)0",
	-100421 => "anti-D(2S)0",
	413 => "D*+",
	-413 => "D*-",
	423 => "D*0",
	-423 => "anti-D*0",
	10413 => "D_1+",
	-10413 => "D_1-",
	10423 => "D_10",
	-10423 => "anti-D_10",
	20413 => "D'_1+",
	-20413 => "D'_1-",
	20423 => "D'_10",
	-20423 => "anti-D'_10",
	100413 => "D*(2S)+",
	-100413 => "D*(2S)-",
	100423 => "D*(2S)0",
	-100423 => "anti-D*(2S)0",
	415 => "D_2*+",
	-415 => "D_2*-",
	425 => "D_2*0",
	-425 => "anti-D_2*0",
	431 => "D_s+",
	-431 => "D_s-",
	10431 => "D_s0*+",
	-10431 => "D_s0*-",
	433 => "D_s*+",
	-433 => "D_s*-",
	10433 => "D_s1+",
	-10433 => "D_s1-",
	20433 => "D'_s1+",
	-20433 => "D'_s1-",
	435 => "D_s2*+",
	-435 => "D_s2*-",
	9000433 => "D_sj(2700)+",
	-9000433 => "D_sj(2700)-",
	441 => "eta_c",
	10441 => "chi_c0",
	100441 => "eta_c(2S)",
	443 => "J/psi",
	10443 => "h_c",
	20443 => "chi_c1",
	100443 => "psi(2S)",
	30443 => "psi(3770)",
	9000443 => "psi(4040)",
	9010443 => "psi(4160)",
	9020443 => "psi(4415)",
	445 => "chi_c2",
	120443 => "X(3872)",
	90000443 => "Y(3940)",
	91000443 => "X(3940)",
	511 => "B0",
	-511 => "anti-B0",
	521 => "B+",
	-521 => "B-",
	10511 => "B_0*0",
	-10511 => "anti-B_0*0",
	10521 => "B_0*+",
	-10521 => "B_0*-",
	513 => "B*0",
	-513 => "anti-B*0",
	523 => "B*+",
	-523 => "B*-",
	10513 => "B_10",
	-10513 => "anti-B_10",
	10523 => "B_1+",
	-10523 => "B_1-",
	20513 => "B'_10",
	-20513 => "anti-B'_10",
	20523 => "B'_1+",
	-20523 => "B'_1-",
	515 => "B_2*0",
	-515 => "anti-B_2*0",
	525 => "B_2*+",
	-525 => "B_2*-",
	531 => "B_s0",
	-531 => "anti-B_s0",
	10531 => "B_s0*0",
	-10531 => "anti-B_s0*0",
	533 => "B_s*0",
	-533 => "anti-B_s*0",
	10533 => "B_s10",
	-10533 => "anti-B_s10",
	20533 => "B'_s10",
	-20533 => "anti-B'_s10",
	535 => "B_s2*0",
	-535 => "anti-B_s2*0",
	541 => "B_c+",
	-541 => "B_c-",
	10541 => "B_c0*+",
	-10541 => "B_c0*-",
	543 => "B_c*+",
	-543 => "B_c*-",
	10543 => "B_c1+",
	-10543 => "B_c1-",
	20543 => "B'_c1+",
	-20543 => "B'_c1-",
	545 => "B_c2*+",
	-545 => "B_c2*-",
	551 => "eta_b",
	10551 => "chi_b0",
	100551 => "eta_b(2S)",
	110551 => "chi_b0(2P)",
	200551 => "eta_b(3S)",
	210551 => "chi_b0(3P)",
	553 => "Upsilon",
	10553 => "h_b",
	20553 => "chi_b1",
	30553 => "Upsilon_1(1D)",
	100553 => "Upsilon(2S)",
	110553 => "h_b(2P)",
	120553 => "chi_b1(2P)",
	130553 => "Upsilon_1(2D)",
	200553 => "Upsilon(3S)",
	210553 => "h_b(3P)",
	220553 => "chi_b1(3P)",
	300553 => "Upsilon(4S)",
	9000553 => "Upsilon(5S)",
	555 => "chi_b2",
	10555 => "eta_b2(1D)",
	20555 => "Upsilon_2(1D)",
	100555 => "chi_b2(2P)",
	110555 => "eta_b2(2D)",
	120555 => "Upsilon_2(2D)",
	200555 => "chi_b2(3P)",
	557 => "Upsilon_3(1D)",
	100557 => "Upsilon_3(2D)",
	2212 => "p+",
	-2212 => "anti-p-",
	2112 => "n0",
	-2112 => "anti-n0",
	12212 => "N(1440)+",
	-12212 => "anti-N(1440)-",
	12112 => "N(1440)0",
	-12112 => "anti-N(1440)0",
	2124 => "N(1520)+",
	-2124 => "anti-N(1520)-",
	1214 => "N(1520)0",
	-1214 => "anti-N(1520)0",
	22212 => "N(1535)+",
	-22212 => "anti-N(1535)-",
	22112 => "N(1535)0",
	-22112 => "anti-N(1535)0",
	2224 => "Delta++",
	-2224 => "anti-Delta--",
	2214 => "Delta+",
	-2214 => "anti-Delta-",
	2114 => "Delta0",
	-2114 => "anti-Delta0",
	1114 => "Delta-",
	-1114 => "anti-Delta+",
	32224 => "Delta(1600)++",
	-32224 => "anti-Delta(1600)--",
	32214 => "Delta(1600)+",
	-32214 => "anti-Delta(1600)-",
	32114 => "Delta(1600)0",
	-32114 => "anti-Delta(1600)0",
	31114 => "Delta(1600)-",
	-31114 => "anti-Delta(1600)+",
	2222 => "Delta(1620)++",
	-2222 => "anti-Delta(1620)--",
	2122 => "Delta(1620)+",
	-2122 => "anti-Delta(1620)-",
	1212 => "Delta(1620)0",
	-1212 => "anti-Delta(1620)0",
	1112 => "Delta(1620)-",
	-1112 => "anti-Delta(1620)+",
	3122 => "Lambda0",
	-3122 => "anti-Lambda0",
	13122 => "Lambda(1405)0",
	-13122 => "anti-Lambda(1405)0",
	3124 => "Lambda(1520)0",
	-3124 => "anti-Lambda(1520)0",
	23122 => "Lambda(1600)0",
	-23122 => "anti-Lambda(1600)0",
	33122 => "Lambda(1670)0",
	-33122 => "anti-Lambda(1670)0",
	13124 => "Lambda(1690)0",
	-13124 => "anti-Lambda(1690)0",
	43122 => "Lambda(1800)0",
	-43122 => "anti-Lambda(1800)0",
	53122 => "Lambda(1810)0",
	-53122 => "anti-Lambda(1810)0",
	3126 => "Lambda(1820)0",
	-3126 => "anti-Lambda(1820)0",
	13126 => "Lambda(1830)0",
	-13126 => "anti-Lambda(1830)0",
	3222 => "Sigma+",
	-3222 => "anti-Sigma-",
	3212 => "Sigma0",
	-3212 => "anti-Sigma0",
	3112 => "Sigma-",
	-3112 => "anti-Sigma+",
	3224 => "Sigma*+",
	-3224 => "anti-Sigma*-",
	3214 => "Sigma*0",
	-3214 => "anti-Sigma*0",
	3114 => "Sigma*-",
	-3114 => "anti-Sigma*+",
	13212 => "Sigma(1660)0",
	-13212 => "anti-Sigma(1660)0",
	13214 => "Sigma(1670)0",
	-13214 => "anti-Sigma(1670)0",
	23212 => "Sigma(1750)0",
	-23212 => "anti-Sigma(1750)0",
	3216 => "Sigma(1775)0",
	-3216 => "anti-Sigma(1775)0",
	3322 => "Xi0",
	-3322 => "anti-Xi0",
	3312 => "Xi-",
	-3312 => "anti-Xi+",
	3324 => "Xi*0",
	-3324 => "anti-Xi*0",
	3314 => "Xi*-",
	-3314 => "anti-Xi*+",
	13324 => "Xi(1820)0",
	-13324 => "anti-Xi(1820)0",
	13314 => "Xi(1820)-",
	-13314 => "anti-Xi(1820)+",
	3334 => "Omega-",
	-3334 => "anti-Omega+",
	13334 => "Omega(2250)-",
	-13334 => "anti-Omega(2250)+",
	4122 => "Lambda_c+",
	-4122 => "anti-Lambda_c-",
	14122 => "Lambda_c(2593)+",
	-14122 => "anti-Lambda_c(2593)-",
	4124 => "Lambda_c(2625)+",
	-4124 => "anti-Lambda_c(2625)-",
	14124 => "Lambda_c(2765)+",
	-14124 => "anti-Lambda_c(2765)-",
	24122 => "Lambda_c(2880)+",
	-24122 => "anti-Lambda_c(2880)-",
	34122 => "Lambda_c(2940)+",
	-34122 => "anti-Lambda_c(2940)-",
	4222 => "Sigma_c++",
	-4222 => "anti-Sigma_c--",
	4212 => "Sigma_c+",
	-4212 => "anti-Sigma_c-",
	4112 => "Sigma_c0",
	-4112 => "anti-Sigma_c0",
	4224 => "Sigma_c*++",
	-4224 => "anti-Sigma_c*--",
	4214 => "Sigma_c*+",
	-4214 => "anti-Sigma_c*-",
	4114 => "Sigma_c*0",
	-4114 => "anti-Sigma_c*0",
	14224 => "Sigma_c(2800)++",
	-14224 => "anti-Sigma_c(2800)--",
	14214 => "Sigma_c(2800)+",
	-14214 => "anti-Sigma_c(2800)-",
	14114 => "Sigma_c(2800)0",
	-14114 => "anti-Sigma_c(2800)0",
	4232 => "Xi_c+",
	-4232 => "anti-Xi_c-",
	4132 => "Xi_c0",
	-4132 => "anti-Xi_c0",
	4322 => "Xi'_c+",
	-4322 => "anti-Xi'_c-",
	4312 => "Xi'_c0",
	-4312 => "anti-Xi'_c0",
	4324 => "Xi_c*+",
	-4324 => "anti-Xi_c*-",
	4314 => "Xi_c*0",
	-4314 => "anti-Xi_c*0",
	14232 => "Xi_c(2790)+",
	-14232 => "anti-Xi_c(2790)-",
#//14232 => "Xi_c(2790)0",
#//-14232 => "anti-Xi_c(2790)0",
	24332 => "Xi_c(2815)+",
	-24332 => "anti-Xi_c(2815)-",
	24132 => "Xi_c(2815)0",
	-24132 => "anti-Xi_c(2815)0",
	34232 => "Xi_c(2980)+",
	-34232 => "anti-Xi_c(2980)-",
	34132 => "Xi_c(2980)0",
	-34132 => "anti-Xi_c(2980)0",
	44232 => "Xi_c(3080)+",
	-44232 => "anti-Xi_c(3080)-",
	44132 => "Xi_c(3080)0",
	-44132 => "anti-Xi_c(3080)0",
	4332 => "Omega_c0",
	-4332 => "anti-Omega_c0",
	4334 => "Omega_c*0",
	-4334 => "anti-Omega_c*0",
	5122 => "Lambda_b0",
	-5122 => "anti-Lambda_b0",
	5112 => "Sigma_b-",
	-5112 => "anti-Sigma_b+",
	5114 => "Sigma_b*-",
	-5114 => "anti-Sigma_b*+",
	5212 => "Sigma_b0",
	-5212 => "anti-Sigma_b0",
	5214 => "Sigma_b*0",
	-5214 => "anti-Sigma_b*0",
	5222 => "Sigma_b+",
	-5222 => "anti-Sigma_b-",
	5224 => "Sigma_b*+",
	-5224 => "anti-Sigma_b*-",
	5132 => "Xi_b-",
	-5132 => "anti-Xi_b+",
	5232 => "Xi_b0",
	-5232 => "anti-Xi_b0",
	5312 => "Xi'_b-",
	-5312 => "anti-Xi'_b+",
	5314 => "Xi_b*-",
	-5314 => "anti-Xi_b*+",
	5322 => "Xi'_b0",
	-5322 => "anti-Xi'_b0",
	5324 => "Xi_b*0",
	-5324 => "anti-Xi_b*0",
	5332 => "Omega_b-",
	-5332 => "anti-Omega_b+",
	5334 => "Omega_b*-",
	-5334 => "anti-Omega_b*+",

);

=func particle_name

takes the Monte Carlo number as input and prints the particle name

=cut

sub particle_name
{
	return "" unless @_;

	return $particles{ $_[0] } || $_[0];
}

=func particle_code

takes a particle name and returns the MC number code

=cut

sub particle_code
{
	return 0 unless @_;

	my $lcname = lc shift;
	my @results = grep { lc( $particles{ $_ } ) eq $lcname } keys %particles;

	return $results[0] // 0;
}

1;
