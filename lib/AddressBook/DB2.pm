#package AddressBook::DB2;
#use strict;
#use Dancer qw(:syntax);
#use Dancer::Plugin::Database;
#use Carp;
#use base "Exporter";
#our @EXPORT = qw(test_select);

## Config
my $sql_file = "SQL/sql.pl"; # here lye sql statements;
my $sql_ref = do $sql_file; 
warning caller;

sub test_select {
    my $sth = database->prepare( $sql_ref->{"test_select"} )
        or croak database->errstr;
    $sth->execute
        or croak $sth->errstr;
    my $entries = $sth->fetchall_hashref("org_id")
        or croak $sth->errstr;

    return $entries;
}

warning "hello!\n";
true;
