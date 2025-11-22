# PREFIX Installation Support

This project now supports customizable installation paths via the PREFIX variable.

## Quick Start

The recommended way to specify a custom PREFIX:

```bash
qmake
make
bash fix-makefiles.sh  # Patch Makefiles to support PREFIX (run AFTER make)
sudo make PREFIX=/usr/local install
```

**Important**: Run `fix-makefiles.sh` **after** `make`, not before, because subdirectory Makefiles are only generated during the build process.

## Details

- **Default PREFIX**: `/usr`  
  Files install to `/usr/bin`, `/usr/share/applications`, etc.

- **Custom PREFIX**: Set to any path like `/usr/local`, `/opt/cool-retro-term`, etc.

## Why fix-makefiles.sh?

qmake generates Makefiles at configuration time with `$(PREFIX)` placeholders in install paths. However, without a default value, PREFIX becomes empty if not specified. The `fix-makefiles.sh` script patches the generated Makefiles to include `.prefix_default.mk` files that define `PREFIX ?= /usr` as the default, while still allowing it to be overridden at make-time with `make PREFIX=/custom/path install`.

**Critical**: The script must be run **after** `make` because:
1. `qmake` generates the root Makefile and creates `.prefix_default.mk` files
2. `make` generates subdirectory Makefiles (like `app/Makefile`)
3. `fix-makefiles.sh` patches all Makefiles that exist

If you run the script before `make`, only the root Makefile will be patched, and the binary won't install to the correct PREFIX location.

**Note about make clean**: After running `make clean` or `make distclean`, the `.prefix_default.mk` files are removed. You must run `qmake` again to regenerate them.

## Examples

Install to `/usr/local`:
```bash
qmake
make
bash fix-makefiles.sh
sudo make PREFIX=/usr/local install
```

Install to `/opt`:
```bash
qmake
make
bash fix-makefiles.sh
sudo make PREFIX=/opt install
```

Install to a staging directory (for packaging):
```bash
qmake
make  
bash fix-makefiles.sh
make install INSTALL_ROOT=/tmp/staging PREFIX=/usr
```

## What Gets Installed

- Binary: `${PREFIX}/bin/cool-retro-term`
- Desktop file: `${PREFIX}/share/applications/cool-retro-term.desktop`
- Icons: 
  - PNG: `${PREFIX}/share/icons/hicolor/{32x32,64x64,128x128,256x256}/apps/cool-retro-term.png`
  - SVG scalable: `${PREFIX}/share/icons/hicolor/scalable/apps/cool-retro-term.svg`
  - SVG symbolic: `${PREFIX}/share/icons/hicolor/symbolic/apps/cool-retro-term-symbolic.svg`
- QML plugin: Uses Qt's standard `$$[QT_INSTALL_QML]` path (not affected by PREFIX)

## For Package Maintainers

If you're packaging cool-retro-term for a distribution:

```bash
qmake
make
bash fix-makefiles.sh
make install INSTALL_ROOT="${pkgdir}" PREFIX=/usr
```

This will install to `${pkgdir}/usr/bin/cool-retro-term` etc., which is the standard for most package systems.
