# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.14

inherit gnome2-utils vala autotools-utils

DESCRIPTION="A unified sound menu"
HOMEPAGE="https://launchpad.net/indicator-sound"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-sound_12.10.2daily13.04.12.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libgee:0
	dev-libs/libindicator:3
	dev-libs/libxml2
	media-sound/pulseaudio[glib]
	x11-libs/bamf
	x11-libs/gtk+:3
	x11-libs/libido:3
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-sound-12.10.2daily13.04.12"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	sed -i 's/-Werror//' src/Makefile.am

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-schemas-compile
	)

	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile -j1
}

src_install() {
	autotools-utils_src_install
	prune_libtool_files --all
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
