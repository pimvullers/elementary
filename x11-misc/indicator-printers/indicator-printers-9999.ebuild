# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="An indicator which shows active print jobs"
HOMEPAGE="https://launchpad.net/indicator-printers"
EBZR_REPO_URI="lp:indicator-printers"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls static-libs"

RDEPEND="
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libindicator:3
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	AUTOTOOLS_AUTORECONF=yes
}

src_prepare() {
	autotools-utils_src_prepare
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

