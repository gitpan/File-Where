#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.02';   # automatically generated file
$DATE = '2004/04/08';


##### Demonstration Script ####
#
# Name: where.d
#
# UUT: File::Where
#
# The module Test::STDmaker generated this demo script from the contents of
#
# t::File::Where 
#
# Don't edit this test script file, edit instead
#
# t::File::Where
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__ @__restore_inc__ );

BEGIN {
    use Cwd;
    use File::Spec;
    use File::TestPath;
    use Test::Tech qw(tech_config plan demo skip_tests);

    ########
    # Working directory is that of the script file
    #
    $__restore_dir__ = cwd();
    my ($vol, $dirs, undef) = File::Spec->splitpath(__FILE__);
    chdir $vol if $vol;
    chdir $dirs if $dirs;

    #######
    # Add the library of the unit under test (UUT) to @INC
    #
    @__restore_inc__ = File::TestPath->test_lib2inc();

    unshift @INC, File::Spec->catdir( cwd(), 'lib' ); 

}

END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;

}

print << 'MSG';

 ~~~~~~ Demonstration overview ~~~~~
 
Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

MSG

demo( "\ \ \ \ use\ File\:\:Spec\;\
\ \ \ \ use\ File\:\:Copy\;\
\ \ \ \ use\ File\:\:Path\;\
\ \ \ \ use\ File\:\:Package\;\
\ \ \ \ my\ \$fp\ \=\ \'File\:\:Package\'\;\
\
\ \ \ \ my\ \$uut\ \=\ \'File\:\:Where\'\;\
\ \ \ \ my\ \$loaded\ \=\ \'\'\;\
\ \ \ \ \#\ Use\ the\ test\ file\ as\ an\ example\ since\ know\ its\ absolute\ path\
\ \ \ \ \#\
\ \ \ \ my\ \$test_script_dir\ \=\ cwd\(\)\;\
\ \ \ \ chdir\ File\:\:Spec\-\>updir\(\)\;\
\ \ \ \ chdir\ File\:\:Spec\-\>updir\(\)\;\
\ \ \ \ my\ \$include_dir\ \=\ cwd\(\)\;\
\ \ \ \ chdir\ \$test_script_dir\;\
\ \ \ \ my\ \$OS\ \=\ \$\^O\;\ \ \#\ need\ to\ escape\ \^\
\ \ \ \ unless\ \(\$OS\)\ \{\ \ \ \#\ on\ some\ perls\ \$\^O\ is\ not\ defined\
\ \ \ \ \ \ \ \ require\ Config\;\
\	\$OS\ \=\ \$Config\:\:Config\{\'osname\'\}\;\
\ \ \ \ \}\ \
\ \ \ \ \$include_dir\ \=\~\ s\=\/\=\\\\\=g\ if\(\ \$OS\ eq\ \'MSWin32\'\)\;\
\ \ \ \ \$test_script_dir\ \=\~\ s\=\/\=\\\\\=g\ if\(\ \$OS\ eq\ \'MSWin32\'\)\;\
\
\ \ \ \ \#\ Put\ base\ directory\ as\ the\ first\ in\ the\ \@INC\ path\
\ \ \ \ \#\
\ \ \ \ my\ \@restore_inc\ \=\ \@INC\;\
\ \ \ \ unshift\ \@INC\,\ \$include_dir\;\ \ \ \ \
\
\ \ \ \ my\ \$relative_file\ \=\ File\:\:Spec\-\>catfile\(\'t\'\,\ \'File\'\,\ \'Where\.pm\'\)\;\ \
\ \ \ \ my\ \$relative_dir1\ \=\ File\:\:Spec\-\>catdir\(\'t\'\,\ \'File\'\)\;\
\ \ \ \ my\ \$relative_dir2\ \=\ File\:\:Spec\-\>catdir\(\'t\'\,\ \'Jolly_Green_Giant\'\)\;\
\
\ \ \ \ my\ \$absolute_file1\ \=\ File\:\:Spec\-\>catfile\(\$include_dir\,\ \'t\'\,\ \'File\'\,\ \'Where\.pm\'\)\;\
\ \ \ \ my\ \$absolute_dir1A\ \=\ File\:\:Spec\-\>catdir\(\$include_dir\,\ \'t\'\,\ \'File\'\)\;\
\ \ \ \ my\ \$absolute_dir1B\ \=\ File\:\:Spec\-\>catdir\(\$include_dir\,\ \'t\'\)\;\
\
\ \ \ \ mkpath\ \(File\:\:Spec\-\>catdir\(\$test_script_dir\,\ \'t\'\,\'File\'\)\)\;\
\ \ \ \ my\ \$absolute_file2\ \=\ File\:\:Spec\-\>catfile\(\$test_script_dir\,\ \'t\'\,\ \'File\'\,\ \'Where\.pm\'\)\;\
\ \ \ \ my\ \$absolute_dir2A\ \=\ File\:\:Spec\-\>catdir\(\$include_dir\,\ \'t\'\,\ \'File\'\,\ \'t\'\,\ \'File\'\)\;\
\ \ \ \ my\ \$absolute_dir2B\ \=\ File\:\:Spec\-\>catdir\(\$include_dir\,\ \'t\'\,\ \'File\'\,\ \'t\'\)\;\
\
\ \ \ \ my\ \$absolute_file_where\ \=\ File\:\:Spec\-\>catdir\(\$include_dir\,\ \'lib\'\,\ \'File\'\,\ \'Where\.pm\'\)\;\
\
\ \ \ \ my\ \@inc2\ \=\ \(\$test_script_dir\,\ \@INC\)\;\ \ \#\ another\ way\ to\ do\ unshift\
\ \ \ \ \
\ \ \ \ copy\ \$absolute_file1\,\$absolute_file2\;\
\
\ \ \ \ my\ \(\@actual\,\$actual\)\;\ \#\ use\ for\ array\ and\ scalar\ context"); # typed in command           
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

    my (@actual,$actual); # use for array and scalar context; # execution

demo( "my\ \$errors\ \=\ \$fp\-\>load_package\(\'File\:\:Where\'\,\ \'where_pm\'\)"); # typed in command           
      my $errors = $fp->load_package('File::Where', 'where_pm'); # execution

demo( "\$errors", # typed in command           
      $errors # execution
) unless     $loaded; # condition for execution                            

demo( "\$actual\ \=\ \$uut\-\>pm2require\(\ \"\$uut\"\)", # typed in command           
      $actual = $uut->pm2require( "$uut")); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where\(\$relative_file\)\]", # typed in command           
      [@actual = $uut->where($relative_file)]); # execution


demo( "\$actual\ \=\ \$uut\-\>where\(\$relative_file\)", # typed in command           
      $actual = $uut->where($relative_file)); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where\(\$relative_file\,\ \[\$test_script_dir\,\ \$include_dir\]\)\]", # typed in command           
      [@actual = $uut->where($relative_file, [$test_script_dir, $include_dir])]); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where\(\$relative_dir1\,\ \'\'\,\ \'nofile\'\)\]", # typed in command           
      [@actual = $uut->where($relative_dir1, '', 'nofile')]); # execution


demo( "\$actual\ \=\ \$uut\-\>where\(\$relative_file\,\ \'\'\,\ \'nofile\'\)", # typed in command           
      $actual = $uut->where($relative_file, '', 'nofile')); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where\(\$relative_dir2\,\ \\\@inc2\,\ \'nofile\'\)\]", # typed in command           
      [@actual = $uut->where($relative_dir2, \@inc2, 'nofile')]); # execution


demo( "\$actual\ \=\ \$uut\-\>where\(\'t\'\,\ \[\$test_script_dir\,\@INC\]\,\ \'nofile\'\)", # typed in command           
      $actual = $uut->where('t', [$test_script_dir,@INC], 'nofile')); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where_file\(\$relative_file\)\]", # typed in command           
      [@actual = $uut->where_file($relative_file)]); # execution


demo( "\$actual\ \=\ \$uut\-\>where_file\(\$relative_file\,\ \$test_script_dir\,\ \$include_dir\)", # typed in command           
      $actual = $uut->where_file($relative_file, $test_script_dir, $include_dir)); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where_dir\(\$relative_dir1\,\ \\\@inc2\)\]", # typed in command           
      [@actual = $uut->where_dir($relative_dir1, \@inc2)]); # execution


demo( "\[\@actual\ \=\ \$uut\-\>where_dir\(\$relative_dir2\,\ \$test_script_dir\)\]", # typed in command           
      [@actual = $uut->where_dir($relative_dir2, $test_script_dir)]); # execution


demo( "\$actual\ \=\ \$uut\-\>where_dir\(\$relative_file\)", # typed in command           
      $actual = $uut->where_dir($relative_file)); # execution


demo( "\[\@actual\=\ \$uut\-\>where_pm\(\ \'t\:\:File\:\:Where\'\ \)\]", # typed in command           
      [@actual= $uut->where_pm( 't::File::Where' )]); # execution


demo( "\$actual\ \=\ \$uut\-\>where_pm\(\ \'t\:\:File\:\:Where\'\,\ \@inc2\)", # typed in command           
      $actual = $uut->where_pm( 't::File::Where', @inc2)); # execution


demo( "\$actual\ \=\ \$uut\-\>where_pm\(\ \'File\:\:Where\'\)", # typed in command           
      $actual = $uut->where_pm( 'File::Where')); # execution


demo( "\$actual\ \=\ where_pm\(\ \'File\:\:Where\'\)", # typed in command           
      $actual = where_pm( 'File::Where')); # execution


demo( "\[\@actual\=\ \$uut\-\>where_pm\(\ \'t\:\:File\:\:Where\'\,\ \[\$test_script_dir\]\)\]", # typed in command           
      [@actual= $uut->where_pm( 't::File::Where', [$test_script_dir])]); # execution


demo( "\[\@actual\=\ \$uut\-\>where_repository\(\ \'t\:\:File\'\ \)\]", # typed in command           
      [@actual= $uut->where_repository( 't::File' )]); # execution


demo( "\$actual\ \=\ \$uut\-\>where_repository\(\ \'t\:\:File\'\,\ \@inc2\)", # typed in command           
      $actual = $uut->where_repository( 't::File', @inc2)); # execution


demo( "\[\@actual\=\ \$uut\-\>where_repository\(\ \'t\:\:Jolly_Green_Giant\'\,\ \[\$test_script_dir\]\)\]", # typed in command           
      [@actual= $uut->where_repository( 't::Jolly_Green_Giant', [$test_script_dir])]); # execution


demo( "\ \ \ \@INC\ \=\ \@restore_inc\;\ \#restore\ \@INC\;\
\ \ \ rmtree\ \'t\'\;"); # typed in command           
         @INC = @restore_inc; #restore @INC;
   rmtree 't';; # execution


=head1 NAME

where.d - demostration script for File::Where

=head1 SYNOPSIS

 where.d

=head1 OPTIONS

None.

=head1 COPYRIGHT

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

## end of test script file ##

=cut

