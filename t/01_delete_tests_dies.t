use strict;
use warnings;
use Test::More;
use Test::Exception;
use 5.010;
use File::Temp qw/ tempfile /;

BEGIN { use_ok 'EPPlication::Schema' }

my ($fh, $dbfile) = tempfile(UNLINK => 1, SUFFIX => '.sqlite');
say "create temporary db file: $dbfile";

my $schema =
  EPPlication::Schema->connect("dbi:SQLite:dbname=$dbfile")
  or die "Unable to connect\n";

$schema->deploy({ add_drop_table => 1 });

my $user = $schema->resultset('User')->create(
    {   name     => 'john',
    }
);
ok($user, 'Create user');

my @tests;
my $num_tests = 3;

for my $i (0 .. $num_tests) {
    $tests[$i] = $user->tests->create(
        {   name => "Test$i",
            type => 'Default',
            user => $user,
        }
    );
    ok($tests[$i], "Created test 'Test$i'");
}
is($user->tests->count, $num_tests+1, 'User has ' . ($num_tests+1) .  ' tests');

#lives_ok( sub { $user->delete }, 'User delete lives.');
lives_ok( sub { $user->tests->delete_all }, 'tests delete lives.');
#for my $t ($user->tests) {
#    print_tests();
#    lives_ok(
#        sub { $t->delete },
#        'test delete lives. (name: ' . $t->name . ' type: ' . $t->type . ')'
#    );
#}

sub print_tests {
    my @tests = $user->tests;
    for my $t (@tests) {
        say $t->name . "\t" . $t->type . "\t" . $t->position;
    }
}

done_testing();
