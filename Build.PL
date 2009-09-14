use Module::Build;
my $build = Module::Build->new(
    module_name        => 'Devel::REPL::Plugin::WGDev',
    license            => 'perl',
    dynamic_config     => 0,
    create_license     => 1,
    create_makefile_pl => 'traditional',
    sign               => 1,
    meta_merge         => {
        resources => {
            bugtracker => 'http://github.com/haarg/devel-repl-plugin-wgdev/issues',
            repository => 'http://github.com/haarg/devel-repl-plugin-wgdev/tree',
        },
    },
    requires => {
        'perl'             => '5.8.8',
        'Devel::REPL'      => 0,
        'Tie::Simple'      => '1.03',
        'WGDev'            => '0.4.0',
    },
);
$build->create_build_script;

