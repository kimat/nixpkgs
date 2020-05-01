{ stdenv
, fetchFromGitHub
, rustPlatform
, pkgconfig
, extra-cmake-modules
, libX11
, libXi
, libXtst
, libnotify
, openssl
, xclip
, xdotool
}:

rustPlatform.buildRustPackage rec {
  pname = "espanso";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "federico-terzi";
    repo = pname;
    rev = "v${version}";
    sha256 = "0hdc83hzcngbzdng0ia7q1hcjss42dapanaibj6i93fcir84rnqp";
  };

  cargoBuildFlags = [
    "--locked"
  ];

  # outputs = [ "out" ];

  cargoSha256 = "1gmysgyacnkhhpq7lybkca6gdzsivj4dgppx0k7fb17pdqwzn9nk";

  nativeBuildInputs = [
    extra-cmake-modules
    pkgconfig
  ];
  buildInputs = [
    libX11
    libXtst
    libXi
    libnotify
    openssl
    xdotool
  ];

  # checkPhase = "cargo test --release --locked";
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Cross-platform Text Expander written in Rust";
    homepage = "https://espanso.org";
    license = licenses.gpl3;
    maintainers = with maintainers; [ kimat ];
    platforms = platforms.all;
  };
}
