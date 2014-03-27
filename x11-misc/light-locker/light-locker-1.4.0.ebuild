# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

DESCRIPTION="A simple locker using lightdm"
HOMEPAGE="https://github.com/the-cavalry/light-locker"
SRC_URI="https://github.com/the-cavalry/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X consolekit nls static-libs systemd upower"

RDEPEND="
	x11-misc/lightdm
	consolekit? ( sys-auth/consolekit )
	systemd? ( sys-apps/systemd )
	upower? ( sys-power/upower )
	X? ( x11-libs/libXxf86vm )"
DEPEND="${RDEPEND}
	X? ( x11-proto/scrnsaverproto )
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS COPYING COPYING.LIB HACKING NEWS README TODO )

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_with systemd)
		$(use_with X x)
		$(use_with X mit-ext)
		$(use_with consolekit console-kit)
		$(use_with upower)
	)

	autotools-utils_src_configure
}
