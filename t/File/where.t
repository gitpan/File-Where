#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.03';   # automatically generated file
$DATE = '2004/04/09';
$FILE = __FILE__;


##### Test Script ####
#
# Name: where.t
#
# UUT: File::Where
#
# The module Test::STDmaker generated this test script from the contents of
#
# t::File::Where;
#
# Don't edit this test script file, edit instead
#
# t::File::Where;
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 

   use FindBin;
   use File::Spec;
   use Cwd;

   ########
   # The working directory for this script file is the directory where
   # the test script resides. Thus, any relative files written or read
   # by this test script are located relative to this test script.
   #
   use vars qw( $__restore_dir__ );
   $__restore_dir__ = cwd();
   my ($vol, $dirs) = File::Spec->splitpath($FindBin::Bin,'nofile');
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Pick up any testing program modules off this test script.
   #
   # When testing on a target site before installation, place any test
   # program modules that should not be installed in the same directory
   # as this test script. Likewise, when testing on a host with a @INC
   # restricted to just raw Perl distribution, place any test program
   # modules in the same directory as this test script.
   #
   use lib $FindBin::Bin;

   ########
   # Using Test::Tech, a very light layer over the module "Test" to
   # conduct the tests.  The big feature of the "Test::Tech: module
   # is that it takes expected and actual references and stringify
   # them by using "Data::Secs2" before passing them to the "&Test::ok"
   # Thus, almost any time of Perl data structures may be
   # compared by passing a reference to them to Test::Tech::ok
   #
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config finish) );
   plan(tests => 22);

}


END {
 
   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @lib::ORIG_INC;
   chdir $__restore_dir__;
}

   # Perl code from C:
    use File::Spec;
    use File::Copy;
    use File::Path;
    use File::Package;
    my $fp = 'File::Package';

    my $uut = 'File::Where';
    my $loaded = '';
    # Use the test file as an example since know its absolute path
    #
    my $test_script_dir = cwd();
    chdir File::Spec->updir();
    chdir File::Spec->updir();
    my $include_dir = cwd();
    chdir $test_script_dir;
    my $OS = $^O;  # need to escape ^
    unless ($OS) {   # on some perls $^O is not defined
        require Config;
	$OS = $Config::Config{'osname'};
    } 
    $include_dir =~ s=/=\\=g if( $OS eq 'MSWin32');
    $test_script_dir =~ s=/=\\=g if( $OS eq 'MSWin32');

    # Put base directory as the first in the @INC path
    #
    my @restore_inc = @INC;

    my $relative_file = File::Spec->catfile('t', 'File', 'Where.pm'); 
    my $relative_dir1 = File::Spec->catdir('t', 'File');
    my $relative_dir2 = File::Spec->catdir('t', 'Jolly_Green_Giant');

    my $absolute_file1 = File::Spec->catfile($include_dir, 't', 'File', 'Where.pm');
    my $absolute_dir1A = File::Spec->catdir($include_dir, 't', 'File');
    my $absolute_dir1B = File::Spec->catdir($include_dir, 't');

    mkpath (File::Spec->catdir($test_script_dir, 't','File'));
    my $absolute_file2 = File::Spec->catfile($test_script_dir, 't', 'File', 'Where.pm');
    my $absolute_dir2A = File::Spec->catdir($include_dir, 't', 'File', 't', 'File');
    my $absolute_dir2B = File::Spec->catdir($include_dir, 't', 'File', 't');

    #####
    # If doing a target site install, blib going to be up front in @INC
    # Locate the include directory with high probability of having the
    # first File::Where in the include path.
    #
    # Really not important that that cheapen test somewhat by doing a quasi
    # where search in that using this to test for a boundary condition where
    # the class, 'File::Where', is the same as the program module 'File::Where
    # that the 'where' subroutine/method is locating.
    #
    my $absolute_dir_where = File::Spec->catdir($include_dir, 'lib');
    foreach (@INC) {
        if ($_ =~ /blib/) {
            $absolute_dir_where = $_ ;
            last;
        }
        elsif ($_ =~ /lib/) {
            $absolute_dir_where = $_ ;
            last;
        }
    }
    my $absolute_file_where = File::Spec->catfile($absolute_dir_where, 'File', 'Where.pm');

    my @inc2 = ($test_script_dir, @INC);  # another way to do unshift
    
    copy $absolute_file1,$absolute_file2;
    unshift @INC, $include_dir;    

    my (@actual,$actual); # use for array and scalar context;

ok(  $loaded = $fp->is_package_loaded('File::Where'), # actual results
      '', # expected results
     "",
     "UUT not loaded");

#  ok:  1

   # Perl code from C:
my $errors = $fp->load_package('File::Where', 'where_pm');

skip_tests( 1 ) unless skip(
      $loaded, # condition to skip test   
      $errors, # actual results
      '',  # expected results
      "",
      "Load UUT");
 
#  ok:  2

ok(  $actual = $uut->pm2require( "$uut"), # actual results
     File::Spec->catfile('File', 'Where' . '.pm'), # expected results
     "",
     "pm2require");

#  ok:  3

ok(  [@actual = $uut->where($relative_file)], # actual results
     [$absolute_file1, $include_dir, $relative_file], # expected results
     "",
     "where finding a file, array context, path absent");

#  ok:  4

ok(  $actual = $uut->where($relative_file), # actual results
     $absolute_file1, # expected results
     "",
     "where finding a file, scalar context, path absent");

#  ok:  5

ok(  [@actual = $uut->where($relative_file, [$test_script_dir, $include_dir])], # actual results
     [$absolute_file2, $test_script_dir, $relative_file], # expected results
     "",
     "where finding a file, array context, array reference path");

#  ok:  6

ok(  [@actual = $uut->where($relative_dir1, '', 'nofile')], # actual results
     [$absolute_dir1A, $include_dir, $relative_dir1], # expected results
     "",
     "where finding a dir, array context, path absent");

#  ok:  7

ok(  $actual = $uut->where($relative_file, '', 'nofile'), # actual results
     $absolute_dir1A, # expected results
     "",
     "where finding a dir, scalar context, path absent");

#  ok:  8

ok(  [@actual = $uut->where($relative_dir2, \@inc2, 'nofile')], # actual results
     [$absolute_dir2B, $test_script_dir, 't'], # expected results
     "",
     "where finding a dir, array context, array reference path");

#  ok:  9

ok(  $actual = $uut->where('t', [$test_script_dir,@INC], 'nofile'), # actual results
     $absolute_dir2B, # expected results
     "",
     "where finding a dir, scalar context, array reference path");

#  ok:  10

ok(  [@actual = $uut->where_file($relative_file)], # actual results
     [$absolute_file1, $include_dir, $relative_file], # expected results
     "",
     "where_file, array context, path absent");

#  ok:  11

ok(  $actual = $uut->where_file($relative_file, $test_script_dir, $include_dir), # actual results
     $absolute_file2, # expected results
     "",
     "where_file, scalar context, array path");

#  ok:  12

ok(  [@actual = $uut->where_dir($relative_dir1, \@inc2)], # actual results
     [$absolute_dir2A, $test_script_dir, $relative_dir1], # expected results
     "",
     "where_dir, array context, array reference");

#  ok:  13

ok(  [@actual = $uut->where_dir($relative_dir2, $test_script_dir)], # actual results
     [$absolute_dir2B, $test_script_dir, 't'], # expected results
     "",
     "where_dir, array context, array reference");

#  ok:  14

ok(  $actual = $uut->where_dir($relative_file), # actual results
     $absolute_dir1A, # expected results
     "",
     "where_dir, scalar context, path absent");

#  ok:  15

ok(  [@actual= $uut->where_pm( 't::File::Where' )], # actual results
     [$absolute_file1, $include_dir, $relative_file], # expected results
     "",
     "where_pm, array context, path absent");

#  ok:  16

ok(  $actual = $uut->where_pm( 't::File::Where', @inc2), # actual results
     $absolute_file2, # expected results
     "",
     "where_pm, scalar context, array path");

#  ok:  17

ok(  $actual = $uut->where_pm( 'File::Where'), # actual results
     $absolute_file_where, # expected results
     "",
     "where_pm, File::Where boundary case");

#  ok:  18

ok(  [@actual= $uut->where_pm( 't::File::Where', [$test_script_dir])], # actual results
     [$absolute_file2, $test_script_dir, $relative_file], # expected results
     "",
     "where_pm subroutine, array context, array reference path");

#  ok:  19

ok(  [@actual= $uut->where_repository( 't::File' )], # actual results
     [$absolute_dir1A, $include_dir, $relative_dir1], # expected results
     "",
     "where_repository, array context, path absent");

#  ok:  20

ok(  $actual = $uut->where_repository( 't::File', @inc2), # actual results
     $absolute_dir2A, # expected results
     "",
     "where_repository, scalar context, array path");

#  ok:  21

ok(  [@actual= $uut->where_repository( 't::Jolly_Green_Giant', [$test_script_dir])], # actual results
     [$absolute_dir2B, $test_script_dir, 't'], # expected results
     "",
     "where_repository, array context, array reference path");

#  ok:  22

   # Perl code from C:
   @INC = @restore_inc; #restore @INC;
   rmtree 't';


    finish();

__END__

=head1 NAME

where.t - test script for File::Where

=head1 SYNOPSIS

 where.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

where.t uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

copyright � 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

/=over 4

/=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

/=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

/=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

## end of test script file ##

