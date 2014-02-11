# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vala gnome2-utils autotools-utils

DESCRIPTION="The bluetooth menu"
HOMEPAGE="https://launchpad.net/indicator-bluetooth"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/indicator-bluetooth_0.0.6%2B14.04.20140124.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/glib-2.38:2
	>=net-wireless/gnome-bluetooth-3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/indicator-bluetooth-0.0.6+14.04.20140124"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.0.6_p20131029-drop-url-dispatcher.patch"
	epatch "${FILESDIR}/${P}-drop-upstart.patch"
	epatch "${FILESDIR}/${PN}-0.0.6_p20131029-symbolic-icons.patch"

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
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
