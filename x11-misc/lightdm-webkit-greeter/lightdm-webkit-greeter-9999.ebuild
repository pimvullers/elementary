# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="A greeter for LightDM that uses Webkit for theming"
HOMEPAGE="https://launchpad.net/lightdm-webkit-greeter"
EBZR_REPO_URI="lp:lightdm-webkit-greeter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/dbus-glib
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-misc/lightdm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog COPYING NEWS README )
}

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh

	cp ${ROOT}/etc/lightdm/lightdm.conf ./
	sed -i '/#\?greeter-session=/ c\greeter-session=lightdm-webkit-greeter' lightdm.conf
}

src_install() {
	autotools-utils_src_install

	insinto /usr/share/xgreeters/
	doins "${FILESDIR}/lightdm-webkit-greeter.desktop"

	insinto /etc/lightdm/
	doins lightdm.conf
}

#pkg_postinst() {
#	einfo "For LightDM to use the Webkit greeter you will need to set"
#	einfo ""
#	einfo "  greeter-session=lightdm-webkit-greeter"
#	einfo ""
#	einfo "in the [SeatDefaults] section of /etc/lightdm/lightdm.conf"
#}

