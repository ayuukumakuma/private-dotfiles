{
  lib,
  fetchFromGitHub,
  makeWrapper,
  python3Packages,
  wget,
}:

python3Packages.buildPythonApplication rec {
  pname = "site2skill";
  version = "0.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "laiso";
    repo = "site2skill";
    rev = "v${version}";
    hash = "sha256-Pn1bjuWzl88ytlDm5hZozAbMlnJclxbxTgAUiZrCZv0=";
  };

  build-system = with python3Packages; [
    hatchling
  ];

  dependencies = with python3Packages; [
    beautifulsoup4
    markdownify
    pyyaml
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  pythonImportsCheck = [
    "site2skill"
  ];

  postFixup = ''
    wrapProgram "$out/bin/site2skill" \
      --prefix PATH : ${lib.makeBinPath [ wget ]}
  '';

  meta = with lib; {
    description = "Turn any documentation website into an agent skill";
    homepage = "https://github.com/laiso/site2skill";
    license = licenses.mit;
    mainProgram = "site2skill";
    platforms = platforms.unix;
  };
}
