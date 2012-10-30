package EPPlication::Schema::Result::User;
use strict;
use warnings;
use base 'DBIx::Class';

__PACKAGE__->load_components(qw/ Core /);
__PACKAGE__->table('users');
__PACKAGE__->add_columns(
    id => {
        data_type => 'int',
        is_numeric => 1,
        is_auto_increment => 1
    },
    name => {
        data_type => 'varchar',
    },
);

__PACKAGE__->set_primary_key ('id');
__PACKAGE__->add_unique_constraint( [ qw/ name / ]  );

__PACKAGE__->has_many(
    'tests',
    'EPPlication::Schema::Result::Test',
    'user_id',
);

1;
