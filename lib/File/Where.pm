#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  File::Where;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '1.13';
$DATE = '2004/04/08';
$FILE = __FILE__;

use File::Spec;
use SelfLoader;

use vars qw(@ISA @EXPORT_OK);
use Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(pm2require where where_dir where_file where_pm where_repository);

# 1

# __DATA__

#####
#
#
sub pm2require
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     File::Spec->catfile( split /::/, $_[0] . '.pm');

}


####
# Find
#
sub where
{

     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my ($relative, $path, $no_file) = @_;
 
     ######
     # Validate inputs
     #
     return undef unless $relative;
     $path = \@INC unless( $path );

     ######
     # Split up the platform dependent file specification into
     # pathform independent perl arrays and strings
     #
     my (undef, $dirs, $file) = File::Spec->splitpath($relative, $no_file); 
     my (@dirs) = File::Spec->splitdir( $dirs );

     my ($abs_file,  $path_dir);
     while( @dirs ) {
         foreach $path_dir (@$path) {
             ######
             # Check for a file or directory
             #
             if( $no_file ) {
                 $abs_file = File::Spec->catdir( $path_dir, $relative);
                 $abs_file = undef unless -d $abs_file;
             }
             else {
                 $abs_file = File::Spec->catfile( $path_dir, @dirs, $file);
                 $abs_file = undef unless -f $abs_file;
             }

             ######
             # If found a file or directory return it.
             # 
             if($abs_file) {

                 my $OS = $^O; 
                 unless ($OS) {   # on some perls $^O is not defined
                    require Config;
	            $OS = $Config::Config{'osname'};
                 } 

                 #### 
                 # MicroSoft thing - cannot decide between Unix or DOS
                 #
                 return $abs_file unless wantarray;
                 $path_dir =~ s|/|\\|g if $OS eq 'MSWin32';
                 return ($abs_file, $path_dir, $relative) if(wantarray);
                 return $abs_file;
             }
         }
         last unless $no_file;
         pop @dirs;
         $relative = File::Spec->catdir(@dirs);
     }
     return (undef,undef,undef) if wantarray;
     return undef;
}


#####
#
#
sub where_dir
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $dir = shift;
     my $path = '';
     if($_[0]) {
         $path = (ref($_[0]) eq 'ARRAY') ? $_[0] : \@_;
     }
     where($dir, $path, 'no_file');
}


#####
#
#
sub where_file
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $file = shift;
     my $path = '';
     if($_[0]) {
         $path = (ref($_[0]) eq 'ARRAY') ? $_[0] : \@_;
     }
     where($file, $path);
}


######
#
#
sub where_pm
{
     #####
     # Simply drop the $self, have a boundary problem for case where
     # for File::Where->where_pm('File::Where');
     # 
     #
     my $self = UNIVERSAL::isa($_[0],__PACKAGE__) ? shift : __PACKAGE__;
     if( @_ == 0 && $self eq 'File::Where' ) {
         return( where_file($self->pm2require('File::Where') ) );
     }
     where_file($self->pm2require(shift), @_);
}


#####
#
#
sub where_repository
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $repository = shift;
     my @repository_dir = split /::/,$repository;
     where_dir(File::Spec->catdir(@repository_dir), @_);
}

1

__END__

=head1 NAME

File::Where - find the absolute file for a program module; absolute dir for a repository

=head1 SYNOPSIS

 #######
 # Subroutine interface
 #  
 use File::PM2File qw(pm2require where where_dir where_file where_pm where_repository);

 $file                            = pm2require($pm);

 $abs_file                        = where($relative_file);
 ($abs_file, $inc_path, $rel_fle) = where($relative_file)
 $abs_file                        = where($relative_file, \@path);
 ($abs_file, $inc_path, $rel_fle) = where($relative_file, \@path)
 $abs_dir                         = where($relative_dir, '', 'nofile'); 
 ($abs_dir, $inc_path, $rel_dir)  = where($relative_dir, '', 'nofile');
 $abs_dir                         = where($relative_dir, \@path, 'nofile'); 
 ($abs_dir, $inc_path, $rel_dir)  = where($relative_dir, \@path, 'nofile');

 $abs_dir                         = where_dir($relative_dir); 
 ($abs_dir, $inc_path, $rel_dir)  = where_dir($relative_dir);
 $abs_dir                         = where_dir($relative_dir, \@path; 
 ($abs_dir, $inc_path, $rel_dir)  = where_dir($relative_dir, \@path);
 $abs_dir                         = where_dir($relative_dir, @path; 
 ($abs_dir, $inc_path, $rel_dir)  = where_dir($relative_dir, @path);

 $abs_file                        = where_file($relative_file);
 ($abs_file, $inc_path, $rel_fle) = where_file($relative_file)
 $abs_file                        = where_file($relative_file, \@path);
 ($abs_file, $inc_path, $rel_fle) = where_file($relative_file, \@path)
 $abs_file                        = where_file($relative_file, @path);
 ($abs_file, $inc_path, $rel_fle) = where_file($relative_file, @path)

 $abs_file                        = where_pm($pm); 
 ($abs_file, $inc_path, $require) = where_pm($pm);
 $abs_file                        = where_pm($pm, \@path);
 ($abs_file, $inc_path, $require) = where_pm($pm, \@path);
 $abs_file                        = where_pm($pm, @path);
 ($abs_file, $inc_path, $require) = where_pm($pm, @path);

 $abs_dir                         = where_repository($repository);
 ($abs_dir,  $inc_path, $rel_dir) = where_repository($repository);
 $abs_dir                         = where_repository($repository, \@path);
 ($abs_dir,  $inc_path, $rel_dir) = where_repository($repository, \@path);
 $abs_dir                         = where_repository($repository, @path);
 ($abs_dir,  $inc_path, $rel_dir) = where_repository($repository, @path);

 #######
 # Class interface
 #
 $file                            = File::PM2File->pm2require($pm);

 $abs_file                        = File::PM2File->where($relative_file);
 ($abs_file, $inc_path, $require) = File::PM2File->where($relative_file)
 $abs_file                        = File::PM2File->where($relative_file, \@path);
 ($abs_file, $inc_path, $require) = File::PM2File->where($relative_file, \@path)
 $abs_dir                         = File::PM2File->where($relative_dir, '', 'nofile'); 
 ($abs_dir, $inc_path, $rel_dir)  = File::PM2File->where($relative_dir, '', 'nofile');
 $abs_dir                         = File::PM2File->where($relative_dir, \@path, 'nofile'); 
 ($abs_dir, $inc_path, $rel_dir)  = File::PM2File->where($relative_dir, \@path, 'nofile');

 $abs_dir                         = File::PM2File->where_dir($relative_dir); 
 ($abs_dir, $inc_path, $rel_dir)  = File::PM2File->where_dir($relative_dir);
 $abs_dir                         = File::PM2File->where_dir($relative_dir, \@path; 
 ($abs_dir, $inc_path, $rel_dir)  = File::PM2File->where_dir($relative_dir, \@path);
 $abs_dir                         = File::PM2File->where_dir($relative_dir, @path; 
 ($abs_dir, $inc_path, $rel_dir)  = File::PM2File->where_dir($relative_dir, @path);

 $abs_file                        = File::PM2File->where_file($relative_file);
 ($abs_file, $inc_path, $require) = File::PM2File->where_file($relative_file)
 $abs_file                        = File::PM2File->where_file($relative_file, \@path);
 ($abs_file, $inc_path, $require) = File::PM2File->where_file($relative_file, \@path)
 $abs_file                        = File::PM2File->where_file($relative_file, @path);
 ($abs_file, $inc_path, $require) = File::PM2File->where_file($relative_file, @path)

 $abs_file                        = File::PM2File->where_pm($pm); 
 ($abs_file, $inc_path, $require) = File::PM2File->where_pm($pm);
 $abs_file                        = File::PM2File->where_pm($pm, \@path);
 ($abs_file, $inc_path, $require) = File::PM2File->where_pm($pm, \@path);
 $abs_file                        = File::PM2File->where_pm($pm, @path);
 ($abs_file, $inc_path, $require) = File::PM2File->where_pm($pm, @path);

 $abs_dir                         = File::PM2File->where_repository($repository);
 ($abs_dir,  $inc_path, $rel_dir) = File::PM2File->where_repository($repository);
 $abs_dir                         = File::PM2File->where_repository($repository, \@path);
 ($abs_dir,  $inc_path, $rel_dir) = File::PM2File->where_repository($repository, \@path);
 $abs_dir                         = File::PM2File->where_repository($repository, @path);
 ($abs_dir,  $inc_path, $rel_dir) = File::PM2File->where_repository($repository, @path);

=head1 DESCRIPTION

From time to time, an program needs to know the abolute file for a program
module that has not been loaded. The File::PM2File module provides methods
to find this information. For loaded files, using the hash %INC may
perform better than using the methods in this module.

=head1 METHODS/SUBROUTINES

=head2 pm2require subroutine

 $file = pm2require($pm_file)

The I<pm2require> method/subroutine returns the file suitable
for use in a Perl C<require> for the C<$pm> program module.

=head2 where subroutine

The where subroutine is the core subroutine call by where_file, where_dir, 
where_pm and where_repository.

When $no_file is absent, 0 or '', the where subroutine performs as established
for the C<where_file> subroutine; otherwise the where subroutine performs as
established for the C<where_dir> subroutine.

The differences is that the C<where> syntax only accepts a reference to an array path
while the C<where_dir> and C<where_file> accept both a reference to an array path
and an array path.

=head2 where_dir subroutine

When $nofile exists and is non-zero,
the C<find_in_include> method/subroutine looks for the C<$relative_dir> under one of the directories in
the C<@path> (C<@INC> path if C<@path> is '' or 0) in the order listed in C<@path> or C<@INC>.
When I<find_in_include> finds the directory, it returns the absolute file C<$absolute_dir> and
the directory C<$path> where it found C<$relative_dir> when the usage calls for an array return;
otherwise, the absolute directory C<$absolute_dir>.

When the C<@path> list of directores exists and is not '' or 0, 
the C<where_dir> subroutine/method
searches the C<@path> list of directories instead of the C<@INC> list of directories.

=head2 where_file subroutine

When $nofile is '', 0 or absent,
the C<find_in_include> method/subroutine looks for the C<$relative_file> in one of the directories in
the C<@path> (C<@INC> path if C<@path> is absent, '' or 0) in the order listed in C<@path> or C<@INC>.
When I<find_in_include> finds the file, it returns the absolute file C<$file_absolute> and
the directory C<$path> where it found C<$file_relative> when the usage calls for an array return;
otherwise, the absolute file C<$file_absolute>.

When the C<@path> list of directores exists and is not '' or 0, 
the C<where_file> subroutine/method
searches the C<@path> list of directories instead of the C<@INC> list of directories.

=head2 where_pm subroutine

In an array context,
the I<where_pm> subroutine/method returns the C<$absolute_file>, 
the directory C<$inc_path> in C<@INC>, and the relative C<$require_file>
for the first directory in C<@INC> list of directories where it found
the program module C<$pm>; otherwise, it returns just the C<$absolute_file>.

When the C<@path> list of directores exists and is not '' or 0, 
the C<where_pm> subroutine/method
searches the C<@path> list of directories instead of the C<@INC> list of directories.

=head2 where_repository subroutine

An repository specifies the location of a number of program modules. For example,
the repository for this program module, C<File::Where>, is C<File::>.

In an array context,
the I<where_repository> subroutine/method returns the C<$absolute_directory>,
the directory C<$inc_path> in C<@INC> for the first directory in C<@INC> list of directories,
and the relative directory of the repository
where it found the C<$repository>; otherwise, it returns just the C<$absolute_file>.\
When I<where_repository> cannot find a directory containing the C<$repository> relative
directory, I<where_repository> pops the last directory off the C<$repository> relative
directory and trys again. If I<where_repository> finds that C<$repository> is empty,
it returns emptys. 

for the C<$repository>; otherwise, it returns just the C<$absolute_directory>.

When the C<@path> list of directores exists and is not '' or 0, 
the C<where_repository> subroutine/method
searches the C<@path> list of directories instead of the C<@INC> list of directories.

=head1 REQUIREMENTS


=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 =>     use File::Spec;
 =>     use File::Copy;
 =>     use File::Path;
 =>     use File::Package;
 =>     my $fp = 'File::Package';

 =>     my $uut = 'File::Where';
 =>     my $loaded = '';
 =>     # Use the test file as an example since know its absolute path
 =>     #
 =>     my $test_script_dir = cwd();
 =>     chdir File::Spec->updir();
 =>     chdir File::Spec->updir();
 =>     my $include_dir = cwd();
 =>     chdir $test_script_dir;
 =>     my $OS = $^O;  # need to escape ^
 =>     unless ($OS) {   # on some perls $^O is not defined
 =>         require Config;
 => 	$OS = $Config::Config{'osname'};
 =>     } 
 =>     $include_dir =~ s=/=\\=g if( $OS eq 'MSWin32');
 =>     $test_script_dir =~ s=/=\\=g if( $OS eq 'MSWin32');

 =>     # Put base directory as the first in the @INC path
 =>     #
 =>     my @restore_inc = @INC;
 =>     unshift @INC, $include_dir;    

 =>     my $relative_file = File::Spec->catfile('t', 'File', 'Where.pm'); 
 =>     my $relative_dir1 = File::Spec->catdir('t', 'File');
 =>     my $relative_dir2 = File::Spec->catdir('t', 'Jolly_Green_Giant');

 =>     my $absolute_file1 = File::Spec->catfile($include_dir, 't', 'File', 'Where.pm');
 =>     my $absolute_dir1A = File::Spec->catdir($include_dir, 't', 'File');
 =>     my $absolute_dir1B = File::Spec->catdir($include_dir, 't');

 =>     mkpath (File::Spec->catdir($test_script_dir, 't','File'));
 =>     my $absolute_file2 = File::Spec->catfile($test_script_dir, 't', 'File', 'Where.pm');
 =>     my $absolute_dir2A = File::Spec->catdir($include_dir, 't', 'File', 't', 'File');
 =>     my $absolute_dir2B = File::Spec->catdir($include_dir, 't', 'File', 't');

 =>     my $absolute_file_where = File::Spec->catdir($include_dir, 'lib', 'File', 'Where.pm');

 =>     my @inc2 = ($test_script_dir, @INC);  # another way to do unshift
 =>     
 =>     copy $absolute_file1,$absolute_file2;

 =>     my (@actual,$actual); # use for array and scalar context
 => my $errors = $fp->load_package('File::Where', 'find_pm')
 => $errors
 'Global symbol "@import" requires explicit package name at (eval 5) line 1.
 	Variable "@import" is not imported at (eval 5) line 1.
 	'

 => $actual = $uut->pm2require( "$uut")
 'File\Where.pm'

 => [@actual = $uut->where($relative_file)]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\Where.pm',
           'E:\User\SoftwareDiamonds\installation',
           't\File\Where.pm'
         ]

 => $actual = $uut->where($relative_file)
 'E:\User\SoftwareDiamonds\installation\t\File\Where.pm'

 => [@actual = $uut->where($relative_file, [$test_script_dir, $include_dir])]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\t\File\Where.pm',
           'E:\User\SoftwareDiamonds\installation\t\File',
           't\File\Where.pm'
         ]

 => [@actual = $uut->where($relative_dir1, '', 'nofile')]
 [
           'E:\User\SoftwareDiamonds\installation\t\File',
           'E:\User\SoftwareDiamonds\installation',
           't\File'
         ]

 => $actual = $uut->where($relative_file, '', 'nofile')
 'E:\User\SoftwareDiamonds\installation\t\File'

 => [@actual = $uut->where($relative_dir2, \@inc2, 'nofile')]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\t',
           'E:\User\SoftwareDiamonds\installation\t\File',
           't'
         ]

 => $actual = $uut->where('t', [$test_script_dir,@INC], 'nofile')
 'E:\User\SoftwareDiamonds\installation\t\File\t'

 => [@actual = $uut->where_file($relative_file)]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\Where.pm',
           'E:\User\SoftwareDiamonds\installation',
           't\File\Where.pm'
         ]

 => $actual = $uut->where_file($relative_file, $test_script_dir, $include_dir)
 'E:\User\SoftwareDiamonds\installation\t\File\t\File\Where.pm'

 => [@actual = $uut->where_dir($relative_dir1, \@inc2)]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\t\File',
           'E:\User\SoftwareDiamonds\installation\t\File',
           't\File'
         ]

 => [@actual = $uut->where_dir($relative_dir2, $test_script_dir)]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\t',
           'E:\User\SoftwareDiamonds\installation\t\File',
           't'
         ]

 => $actual = $uut->where_dir($relative_file)
 'E:\User\SoftwareDiamonds\installation\t\File'

 => [@actual= $uut->where_pm( 't::File::Where' )]
 [
           'E:\User\SoftwareDiamonds\installation\t\File\Where.pm',
           'E:\User\SoftwareDiamonds\installation',
           't\File\Where.pm'
         ]

 => $actual = $uut->where_pm( 't::File::Where', @inc2)
 'E:\User\SoftwareDiamonds\installation\t\File\t\File\Where.pm'

 => $actual = $uut->where_pm( 'File::Where')
 'E:\User\SoftwareDiamonds\installation\lib\File\Where.pm'


=head1 QUALITY ASSURANCE

Running the test script 'PM2File.t' found in
the "File-PM2File-$VERSION.tar.gz" distribution file verifies
the requirements for this module.

All testing software and documentation
stems from the 
Software Test Description (L<STD|Docs::US_DOD::STD>)
program module 't::File::PM2File',
found in the distribution file 
"File-PM2File-$VERSION.tar.gz". 

The 't::File::PM2File' L<STD|Docs::US_DOD::STD> POD contains
a tracebility matix between the
requirements established above for this module, and
the test steps identified by a
'ok' number from running the 'PM2File.t'
test script.

The t::File::PM2File' L<STD|Docs::US_DOD::STD>
program module '__DATA__' section contains the data 
to perform the following:

=over 4

=item *

to generate the test script 'PM2File.t'

=item *

generate the tailored 
L<STD|Docs::US_DOD::STD> POD in
the 't::File::PM2File' module, 

=item *

generate the 'PM2File.d' demo script, 

=item *

replace the POD demonstration section
herein with the demo script
'PM2File.d' output, and

=item *

run the test script using Test::Harness
with or without the verbose option,

=back

To perform all the above, prepare
and run the automation software as 
follows:

=over 4

=item *

Install "Test_STDmaker-$VERSION.tar.gz"
from one of the respositories only
if it has not been installed:

=over 4

=item *

http://www.softwarediamonds/packages/

=item *

http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/

=back
  
=item *

manually place the script tmake.pl
in "Test_STDmaker-$VERSION.tar.gz' in
the site operating system executable 
path only if it is not in the 
executable path

=item *

place the 't::File::PM2File' at the same
level in the directory struture as the
directory holding the 'File::PM2File'
module

=item *

execute the following in any directory:

 tmake -test_verbose -replace -run -pm=t::File::PM2File

=back

=head1 NOTES

=head2 FILES

The installation of the
"File-PM2File-$VERSION.tar.gz" distribution file
installs the 'Docs::Site_SVD::File_PM2File'
L<SVD|Docs::US_DOD::SVD> program module.

The __DATA__ data section of the 
'Docs::Site_SVD::File_PM2File' contains all
the necessary data to generate the POD
section of 'Docs::Site_SVD::File_PM2File' and
the "File-PM2File-$VERSION.tar.gz" distribution file.

To make use of the 
'Docs::Site_SVD::File_PM2File'
L<SVD|Docs::US_DOD::SVD> program module,
perform the following:

=over 4

=item *

install "ExtUtils-SVDmaker-$VERSION.tar.gz"
from one of the respositories only
if it has not been installed:

=over 4

=item *

http://www.softwarediamonds/packages/

=item *

http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/

=back

=item *

manually place the script vmake.pl
in "ExtUtils-SVDmaker-$VERSION.tar.gz' in
the site operating system executable 
path only if it is not in the 
executable path

=item *

Make any appropriate changes to the
__DATA__ section of the 'Docs::Site_SVD::File_PM2File'
module.
For example, any changes to
'File::PM2File' will impact the
at least 'Changes' field.

=item *

Execute the following:

 vmake readme_html all -pm=Docs::Site_SVD::File_PM2File

=back

=head2 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http::www.softwarediamonds.com,
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


=for html
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
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###