# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bzr

DESCRIPTION="Pantheon Login Screen for the LightDM Webkit Greeter"
HOMEPAGE="https://launchpad.net/pantheon-greeter"
EBZR_REPO_URI="lp:pantheon-greeter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/libindicator:3
	x11-misc/lightdm
	x11-misc/lightdm-webkit-greeter"
DEPEND=""

src_install() {
	insinto /usr/share/lightdm-webkit/themes/
	doins -r pantheon

	insinto /etc/lightdm/
	doins "${FILESDIR}"/lightdm-webkit-greeter.conf
}

#pkg_postinst() {
#	einfo "For the LightDM Webkit greeter to use the Pantheon theme you will need to set"
#	einfo ""
#	einfo "  webkit-theme=pantheon"
#	einfo ""
#	einfo "in the [greeter] section of /etc/lightdm/lightdm-webkit-greeter.conf"
#}

