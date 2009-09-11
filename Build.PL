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
        },
    },
    requires => {
        'perl'             => '5.8.8',
        'WGDev'            => '0.5.0',
        'Devel::REPL'      => 0,
    },
);
$build->create_build_script;

