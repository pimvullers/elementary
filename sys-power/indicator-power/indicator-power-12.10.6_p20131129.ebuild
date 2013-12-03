# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="The Power Indicator"
HOMEPAGE="http://launchpad.net/indicator-power"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-power_12.10.6%2B14.04.20131129.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.35.4:2
	>=virtual/udev-204"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-power-12.10.6+14.04.20131129"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch "${FILESDIR}/${P}-drop-url-dispatcher.patch"

	autotools-utils_src_prepare
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
