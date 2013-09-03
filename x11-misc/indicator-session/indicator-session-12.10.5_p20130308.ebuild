# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="Session indicator"
HOMEPAGE="https://launchpad.net/indicator-session"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_12.10.5daily13.03.08.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.35.4:2
	>=dev-libs/libdbusmenu-0.5.90:3[gtk]
	dev-libs/libindicator:3
	!pantheon-extra/indicator-pantheon-session
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-session-12.10.5daily13.03.08"
AUTOTOOLS_AUTORECONF=1

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

