# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/indicator-messages/indicator-messages-0.3.11.ebuild,v 1.1 2010/09/21 20:47:26 eva Exp $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="A unified messaging menu"
HOMEPAGE="https://launchpad.net/indicator-applet/"
EBZR_REPO_URI="lp:indicator-applet"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND=">=dev-libs/glib-2.18:2
	x11-libs/gtk+:3
	>=dev-libs/libindicate-0.3
	>=dev-libs/libindicator-0.3.5
	>=dev-libs/libdbusmenu-0.2.8[gtk]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

DOCS=(AUTHORS)

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
	)

	autotools-utils_src_configure
}

