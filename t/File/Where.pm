#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  t::File::Where;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.02';
$DATE = '2004/04/08';
$FILE = __FILE__;

########
# The Test::STDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time Test::STDmaker generates this file.
#
#


=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl File::Where Program Module

 Revision: -

 Version: 

 Date: 2004/04/08

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<File::Where|File::Where>

The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.
in accordance with 
L<Detail STD Format|Test::STDmaker/Detail STD Format>.

#######
#  
#  4. TEST DESCRIPTIONS
#
#  4.1 Test 001
#
#  ..
#
#  4.x Test x
#
#

=head1 TEST DESCRIPTIONS

The test descriptions uses a legend to
identify different aspects of a test description
in accordance with
L<STD FormDB Test Description Fields|Test::STDmaker/STD FormDB Test Description Fields>.

=head2 Test Plan

 T: 23^

=head2 ok: 1


  C:
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
     my $OS = $^^O;  # need to escape ^^
     unless ($OS) {   # on some perls $^^O is not defined
         require Config;
 	$OS = $Config::Config{'osname'};
     } 
     $include_dir =~ s=/=\\=g if( $OS eq 'MSWin32');
     $test_script_dir =~ s=/=\\=g if( $OS eq 'MSWin32');
     # Put base directory as the first in the @INC path
     #
     my @restore_inc = @INC;
     unshift @INC, $include_dir;    
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
     my $absolute_file_where = File::Spec->catdir($include_dir, 'lib', 'File', 'Where.pm');
     my @inc2 = ($test_script_dir, @INC);  # another way to do unshift
     
     copy $absolute_file1,$absolute_file2;
     my (@actual,$actual); # use for array and scalar context
 ^
 VO: ^
  N: UUT not loaded^
  A: $loaded = $fp->is_package_loaded('File::Where')^
  E:  ''^
 ok: 1^

=head2 ok: 2

  N: Load UUT^
  S: $loaded^
  C: my $errors = $fp->load_package('File::Where', 'where_pm')^
  A: $errors^
 SE: ''^
 ok: 2^

=head2 ok: 3

  N: pm2require^
  A: $actual = $uut->pm2require( "$uut")^
  E: File::Spec->catfile('File', 'Where' . '.pm')^
 ok: 3^

=head2 ok: 4

  N: where finding a file, array context, path absent^
  A: [@actual = $uut->where($relative_file)]^
  E: [$absolute_file1, $include_dir, $relative_file]^
 ok: 4^

=head2 ok: 5

  N: where finding a file, scalar context, path absent^
  A: $actual = $uut->where($relative_file)^
  E: $absolute_file1^
 ok: 5^

=head2 ok: 6

  N: where finding a file, array context, array reference path^
  A: [@actual = $uut->where($relative_file, [$test_script_dir, $include_dir])]^
  E: [$absolute_file2, $test_script_dir, $relative_file]^
 ok: 6^

=head2 ok: 7

  N: where finding a dir, array context, path absent^
  A: [@actual = $uut->where($relative_dir1, '', 'nofile')]^
  E: [$absolute_dir1A, $include_dir, $relative_dir1]^
 ok: 7^

=head2 ok: 8

  N: where finding a dir, scalar context, path absent^
  A: $actual = $uut->where($relative_file, '', 'nofile')^
  E: $absolute_dir1A^
 ok: 8^

=head2 ok: 9

  N: where finding a dir, array context, array reference path^
  A: [@actual = $uut->where($relative_dir2, \@inc2, 'nofile')]^
  E: [$absolute_dir2B, $test_script_dir, 't']^
 ok: 9^

=head2 ok: 10

  N: where finding a dir, scalar context, array reference path^
  A: $actual = $uut->where('t', [$test_script_dir,@INC], 'nofile')^
  E: $absolute_dir2B^
 ok: 10^

=head2 ok: 11

  N: where_file, array context, path absent^
  A: [@actual = $uut->where_file($relative_file)]^
  E: [$absolute_file1, $include_dir, $relative_file]^
 ok: 11^

=head2 ok: 12

  N: where_file, scalar context, array path^
  A: $actual = $uut->where_file($relative_file, $test_script_dir, $include_dir)^
  E: $absolute_file2^
 ok: 12^

=head2 ok: 13

  N: where_dir, array context, array reference^
  A: [@actual = $uut->where_dir($relative_dir1, \@inc2)]^
  E: [$absolute_dir2A, $test_script_dir, $relative_dir1]^
 ok: 13^

=head2 ok: 14

  N: where_dir, array context, array reference^
  A: [@actual = $uut->where_dir($relative_dir2, $test_script_dir)]^
  E: [$absolute_dir2B, $test_script_dir, 't']^
 ok: 14^

=head2 ok: 15

  N: where_dir, scalar context, path absent^
  A: $actual = $uut->where_dir($relative_file)^
  E: $absolute_dir1A^
 ok: 15^

=head2 ok: 16

  N: where_pm, array context, path absent^
  A: [@actual= $uut->where_pm( 't::File::Where' )]^
  E: [$absolute_file1, $include_dir, $relative_file]^
 ok: 16^

=head2 ok: 17

  N: where_pm, scalar context, array path^
  A: $actual = $uut->where_pm( 't::File::Where', @inc2)^
  E: $absolute_file2^
 ok: 17^

=head2 ok: 18

  N: where_pm subroutine, File::Where boundary case^
  A: $actual = $uut->where_pm( 'File::Where')^
  E: $absolute_file_where^
 ok: 18^

=head2 ok: 19

  N: where_pm, File::Where boundary case^
  A: $actual = where_pm( 'File::Where')^
  E: $absolute_file_where^
 ok: 19^

=head2 ok: 20

  N: where_pm, array context, array reference path^
  A: [@actual= $uut->where_pm( 't::File::Where', [$test_script_dir])]^
  E: [$absolute_file2, $test_script_dir, $relative_file]^
 ok: 20^

=head2 ok: 21

  N: where_repository, array context, path absent^
  A: [@actual= $uut->where_repository( 't::File' )]^
  E: [$absolute_dir1A, $include_dir, $relative_dir1]^
 ok: 21^

=head2 ok: 22

  N: where_repository, scalar context, array path^
  A: $actual = $uut->where_repository( 't::File', @inc2)^
  E: $absolute_dir2A^
 ok: 22^

=head2 ok: 23

  N: where_repository, array context, array reference path^
  A: [@actual= $uut->where_repository( 't::Jolly_Green_Giant', [$test_script_dir])]^
  E: [$absolute_dir2B, $test_script_dir, 't']^
 ok: 23^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------


=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

copyright © 2003 Software Diamonds.

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

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

L<File::Where>

=back

=for html
<hr>
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

__DATA__

File_Spec: Unix^
UUT: File::Where^
Revision: -^
End_User: General Public^
Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Detail_Template: ^
STD2167_Template: ^
Version: ^
Classification: None^
Temp: temp.pl^
Demo: where.d^
Verify: where.t^


 T: 23^


 C:
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
    my $OS = $^^O;  # need to escape ^^
    unless ($OS) {   # on some perls $^^O is not defined
        require Config;
	$OS = $Config::Config{'osname'};
    } 
    $include_dir =~ s=/=\\=g if( $OS eq 'MSWin32');
    $test_script_dir =~ s=/=\\=g if( $OS eq 'MSWin32');

    # Put base directory as the first in the @INC path
    #
    my @restore_inc = @INC;
    unshift @INC, $include_dir;    

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

    my $absolute_file_where = File::Spec->catdir($include_dir, 'lib', 'File', 'Where.pm');

    my @inc2 = ($test_script_dir, @INC);  # another way to do unshift
    
    copy $absolute_file1,$absolute_file2;

    my (@actual,$actual); # use for array and scalar context
^

VO: ^
 N: UUT not loaded^
 A: $loaded = $fp->is_package_loaded('File::Where')^
 E:  ''^
ok: 1^

 N: Load UUT^
 S: $loaded^
 C: my $errors = $fp->load_package('File::Where', 'where_pm')^
 A: $errors^
SE: ''^
ok: 2^

 N: pm2require^
 A: $actual = $uut->pm2require( "$uut")^
 E: File::Spec->catfile('File', 'Where' . '.pm')^
ok: 3^

 N: where finding a file, array context, path absent^
 A: [@actual = $uut->where($relative_file)]^
 E: [$absolute_file1, $include_dir, $relative_file]^
ok: 4^

 N: where finding a file, scalar context, path absent^
 A: $actual = $uut->where($relative_file)^
 E: $absolute_file1^
ok: 5^

 N: where finding a file, array context, array reference path^
 A: [@actual = $uut->where($relative_file, [$test_script_dir, $include_dir])]^
 E: [$absolute_file2, $test_script_dir, $relative_file]^
ok: 6^

 N: where finding a dir, array context, path absent^
 A: [@actual = $uut->where($relative_dir1, '', 'nofile')]^
 E: [$absolute_dir1A, $include_dir, $relative_dir1]^
ok: 7^

 N: where finding a dir, scalar context, path absent^
 A: $actual = $uut->where($relative_file, '', 'nofile')^
 E: $absolute_dir1A^
ok: 8^

 N: where finding a dir, array context, array reference path^
 A: [@actual = $uut->where($relative_dir2, \@inc2, 'nofile')]^
 E: [$absolute_dir2B, $test_script_dir, 't']^
ok: 9^

 N: where finding a dir, scalar context, array reference path^
 A: $actual = $uut->where('t', [$test_script_dir,@INC], 'nofile')^
 E: $absolute_dir2B^
ok: 10^

 N: where_file, array context, path absent^
 A: [@actual = $uut->where_file($relative_file)]^
 E: [$absolute_file1, $include_dir, $relative_file]^
ok: 11^

 N: where_file, scalar context, array path^
 A: $actual = $uut->where_file($relative_file, $test_script_dir, $include_dir)^
 E: $absolute_file2^
ok: 12^

 N: where_dir, array context, array reference^
 A: [@actual = $uut->where_dir($relative_dir1, \@inc2)]^
 E: [$absolute_dir2A, $test_script_dir, $relative_dir1]^
ok: 13^

 N: where_dir, array context, array reference^
 A: [@actual = $uut->where_dir($relative_dir2, $test_script_dir)]^
 E: [$absolute_dir2B, $test_script_dir, 't']^
ok: 14^

 N: where_dir, scalar context, path absent^
 A: $actual = $uut->where_dir($relative_file)^
 E: $absolute_dir1A^
ok: 15^

 N: where_pm, array context, path absent^
 A: [@actual= $uut->where_pm( 't::File::Where' )]^
 E: [$absolute_file1, $include_dir, $relative_file]^
ok: 16^

 N: where_pm, scalar context, array path^
 A: $actual = $uut->where_pm( 't::File::Where', @inc2)^
 E: $absolute_file2^
ok: 17^

 N: where_pm, File::Where boundary case^
 A: $actual = $uut->where_pm( 'File::Where')^
 E: $absolute_file_where^
ok: 18^

 N: where_pm, File::Where boundary case^
 A: $actual = where_pm( 'File::Where')^
 E: $absolute_file_where^
ok: 19^

 N: where_pm subroutine, array context, array reference path^
 A: [@actual= $uut->where_pm( 't::File::Where', [$test_script_dir])]^
 E: [$absolute_file2, $test_script_dir, $relative_file]^
ok: 20^

 N: where_repository, array context, path absent^
 A: [@actual= $uut->where_repository( 't::File' )]^
 E: [$absolute_dir1A, $include_dir, $relative_dir1]^
ok: 21^

 N: where_repository, scalar context, array path^
 A: $actual = $uut->where_repository( 't::File', @inc2)^
 E: $absolute_dir2A^
ok: 22^

 N: where_repository, array context, array reference path^
 A: [@actual= $uut->where_repository( 't::Jolly_Green_Giant', [$test_script_dir])]^
 E: [$absolute_dir2B, $test_script_dir, 't']^
ok: 23^


 C:
   @INC = @restore_inc; #restore @INC;
   rmtree 't';
^


See_Also: L<File::Where>^

Copyright:
copyright © 2003 Software Diamonds.

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
^


HTML:
<hr>
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>
^



~-~
