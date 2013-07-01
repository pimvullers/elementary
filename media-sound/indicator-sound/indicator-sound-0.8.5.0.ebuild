# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.14

inherit gnome2-utils vala autotools-utils

DESCRIPTION="A unified sound menu"
HOMEPAGE="https://launchpad.net/indicator-sound"
SRC_URI="http://launchpad.net/${PN}/fifth/0.8.5/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libgee
	>=dev-libs/libindicator-0.4.90:3
	dev-libs/libxml2
	gnome-base/gconf:2
	media-sound/pulseaudio[glib]
	x11-libs/gtk+:3
	x11-libs/libido:3
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-schemas-compile
	)

	autotools-utils_src_configure
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