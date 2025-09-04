# AMD hardware profile - for systems with AMD CPUs/GPUs
{ ... }:
{
  imports = [
    ../amdctl # AMD CPU control
    ../lact # AMD GPU control
  ];
}
