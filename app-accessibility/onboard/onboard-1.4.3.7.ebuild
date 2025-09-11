# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10,11,12,13} )

inherit gnome2 distutils-r1 python-utils-r1

MY_PV=$(ver_rs 3 -)
DESCRIPTION="Onscreen keyboard for everybody who can't use a hardware keyboard"
HOMEPAGE="https://github.com/onboard-osk/onboard"
SRC_URI="https://github.com/onboard-osk/${PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

# po/* are licensed under BSD 3-clause
LICENSE="GPL-3+ BSD"
SLOT="0"
KEYWORDS="amd64"

COMMON_DEPEND="app-text/hunspell:=
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	sys-apps/dbus
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[introspection]
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	x11-libs/libwnck:3
	x11-libs/pango"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	app-accessibility/at-spi2-core
	app-text/iso-codes
	gnome-extra/mousetweaks
	x11-libs/libxkbfile"

RESTRICT="mirror"

# These are using a functionality of distutils-r1.eclass
DOCS=( AUTHORS CHANGELOG HACKING README.md onboard-defaults.conf.example
	onboard-default-settings.gschema.override.example )
PATCHES=( "${FILESDIR}/${P}-remove-duplicated-docs.patch" )

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	eapply_user
	sed -i -e 's/.*bool.*/#include <stdbool.h>/' "${S}/Onboard/osk/osk_module.h"
	sed -i -e 's/if not os.getenv("FAKEROOTKEY"):/if False:/' "${S}/setup.py"
}

src_install() {
	distutils-r1_src_install

	# Delete duplicated docs installed by original distutils
	rm "${D}"/usr/share/doc/onboard/*

	python_setup
	mkdir -p "${ED}/etc/xdg/autostart/"
	mv "${ED}$(python_get_sitedir)/etc/xdg/autostart/onboard-autostart.desktop" "${ED}/etc/xdg/autostart/onboard-autostart.desktop"
}
