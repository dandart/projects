# This file has been generated by node2nix 1.8.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "gl-matrix-3.3.0" = {
      name = "gl-matrix";
      packageName = "gl-matrix";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/gl-matrix/-/gl-matrix-3.3.0.tgz";
        sha512 = "COb7LDz+SXaHtl/h4LeaFcNdJdAQSDeVqjiIihSXNrkWObZLhDI4hIkZC11Aeqp7bcE72clzB0BnDXr2SmslRA==";
      };
    };
  };
  args = {
    name = "webgl";
    packageName = "webgl";
    version = "2.0.0";
    src = ./.;
    dependencies = [
      sources."gl-matrix-3.3.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "WebGL Project v2";
      license = "ISC";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
in
{
  args = args;
  sources = sources;
  tarball = nodeEnv.buildNodeSourceDist args;
  package = nodeEnv.buildNodePackage args;
  shell = nodeEnv.buildNodeShell args;
}