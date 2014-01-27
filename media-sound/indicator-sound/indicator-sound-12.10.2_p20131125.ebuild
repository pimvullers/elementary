# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.14

inherit gnome2-utils vala cmake-utils

DESCRIPTION="A unified sound menu"
HOMEPAGE="https://launchpad.net/indicator-sound"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-sound_12.10.2%2B14.04.20131125.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.38:2
	dev-libs/libgee:0.8
	dev-libs/libxml2
	media-sound/pulseaudio[glib]
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-sound-12.10.2+14.04.20131125"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch "${FILESDIR}/${P}-drop-url-dispatcher.patch"
	epatch "${FILESDIR}/${P}-drop-upstart.patch"
	epatch "${FILESDIR}/${P}-unowned.patch"
	epatch "${FILESDIR}/${P}-symbolic-icons.patch"

	sed -i 's/add_subdirectory(tests)//' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_COMPILER="${VALAC}"
	)

	cmake-utils_src_configure 
}

#src_compile() {
#	autotools-utils_src_compile -j1
#}

#src_install() {
#	autotools-utils_src_install
#	prune_libtool_files --all
#}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
