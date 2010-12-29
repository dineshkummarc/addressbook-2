package AddressBook::Plugin::MountCode;
use strict;
use warnings;

use Dancer qw(:syntax);
use Dancer::Plugin;
use Carp;
use Data::Dumper;

my $settings = plugin_setting;

register show_settings => sub {
    print Dumper($settings);
};

register mount_code => sub {
    while (my ($description, $file) = each %{$settings}) {
        open my $fh, "<", $file
            or croak "cannot open $file at $description : $!\n";
        
        my $code = do { local $/= undef; <$fh> };
#        warning caller;
        my $current_pack = __PACKAGE__;
        my $caller_pack  = caller;
        warning $caller_pack;
#        {
#            no strict 'refs';
#            *{$caller_pack . "::"} = \*{$current_pack . "::"};
#        }
        my $eval = qq/package $caller_pack;\n $code/;
#        warning __PACKAGE__;
        eval $eval;
        if ($@) {
            croak "while execution code some errors occured see the:\n" .
                "$description" . ":" . "$file";
        }
    }
#    test_select();
};


register_plugin;

1;

