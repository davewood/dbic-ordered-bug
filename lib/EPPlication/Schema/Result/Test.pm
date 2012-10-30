package EPPlication::Schema::Result::Test;
use strict;
use warnings;
use base qw/DBIx::Class/;
__PACKAGE__->load_components(qw/ Ordered Core /);
__PACKAGE__->table('tests');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'int',
        is_numeric        => 1,
        is_auto_increment => 1
    },
    name     => { data_type => 'varchar' },
    position => { data_type => 'int' },
    user_id  => {
        data_type      => 'int',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    type => {
        data_type     => 'varchar',
        default_value => 'StandAlone',
    }
);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->position_column('position');
__PACKAGE__->grouping_column([ qw/ user_id type / ]);
__PACKAGE__->add_unique_constraint([ qw/ user_id type position / ]);
__PACKAGE__->resultset_attributes(
    { order_by => { -asc => [qw/ user_id type position /] } });

__PACKAGE__->belongs_to(
    'user',
    'EPPlication::Schema::Result::User',
    'user_id'
);

1;
