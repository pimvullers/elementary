# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils

DESCRIPTION="Default settings for the Pantheon Desktop Environment"
HOMEPAGE="https://github.com/elementary/default-settings"
SRC_URI="https://github.com/elementary/default-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="no license"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	x11-themes/elementary-icons-theme
	x11-themes/elementary-sound-theme
	x11-themes/elementary-theme
	x11-themes/elementary-wallpapers
"

S="${WORKDIR}/default-settings-${PV}"

src_prepare() {
	eapply_user
	#mv debian/elementary-default-settings.gsettings-override \
	#	${P}.gschema.override

	# Replace Open Sans with Droid Sans as we don't have Open Sans yet
	sed -i -e 's/Open Sans/Droid Sans/' debian/elementary-default-settings.gsettings-override

	# Rename DMZ-Black to Vanilla-DMZ-AA as that's the name in Gentoo
	sed -i -e 's/DMZ-Black/Vanilla-DMZ-AA/' debian/elementary-default-settings.gsettings-override
}

src_install() {

	#policykit.desktop
	insinto /usr/share/applications/
	doins sessioninstaller.desktop

	insinto /usr/share/glib-2.0/schemas/
	doins debian/elementary-default-settings.gsettings-override

	insinto /etc/profile.d/
	doins profile.d/*.sh

	insinto /etc/skel/.config/plank/
	doins -r plank/dock1

	insinto /etc/gtk-3.0/
	doins settings.ini

	insinto /etc/wingpanel.d/
	doins wingpanel.d/*

	insinto /etc/sudoers.d/
	doins sudoers.d/*
}

pkg_postinst() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}

pkg_postrm() {
	GNOME2_ECLASS_GLIB_SCHEMAS=1 gnome2_schemas_update
}
