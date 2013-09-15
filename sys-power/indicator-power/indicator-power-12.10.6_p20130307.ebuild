# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="The Power Indicator"
HOMEPAGE="http://launchpad.net/indicator-power"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_12.10.6daily13.03.07.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.35.4:2
	dev-libs/libindicator:3
	>=gnome-base/gnome-settings-daemon-3.1.4
	sys-power/upower
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-power-12.10.6daily13.03.07"
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
